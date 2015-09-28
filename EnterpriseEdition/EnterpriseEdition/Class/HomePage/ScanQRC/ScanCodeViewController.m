//
//  ScanCodeViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/9/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "JobFairInfoViewController.h"
#import "ResumeInfoViewController.h"
#import "JobFairListView.h"
#import "UIDevice+Extensions.h"


#define kScanWidth [Util myXOrWidth:250]
#define kScanY [Util myYOrHeight:80]
@interface ScanCodeViewController ()<JobFairListViewDelegate>

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"二维码扫描";
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    if ([UIDevice isSimulator]) {
        
    }else
    {
        if ([self enableCamera]) {
            [self initScanView];
        }else
        {
            [Util showPrompt:@"请到设置中打开照相机访问权限"];
        }
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([UIDevice isSimulator]) {
        [Util showPrompt:@"模拟器不可以扫描二维码"];
    }else
    {
        if ([self enableCamera]) {
            [self setupCamera];
        }
        
    }
    
}
-(void)initScanView
{
    float imgW = kScanWidth;
    float imgX = (kWidth-imgW)/2;
    float imgY = kScanY;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imgX,imgY ,imgW,imgW)];
    imageView.image = [UIImage imageNamed:@"home_pick_bg"];
    [self.view addSubview:imageView];
    
    //遮罩视图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, imgY)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.35;
    [self.view addSubview:bgView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, imgY, imgX, imgW)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.35;
    [self.view addSubview:bgView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(imgX+imgW, imgY, imgX, imgW)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.35;
    [self.view addSubview:bgView];
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, imgY+imgW, kWidth, kHeight-(imgY+imgW+topBarheight))];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.35;
    [self.view addSubview:bgView];
    
    
    float fontSize = 17;
    if (kIphone5||kIphone4) {
        fontSize = 14;
    }
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(imgX, imgY+imgW+[Util myYOrHeight:20], imgW, 50)];
    labIntroudction.font = [UIFont systemFontOfSize:fontSize];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor greenColor];
    labIntroudction.text=@"请将简历id或签到二维码放置框内";
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labIntroudction];
    
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, kWidth-100, 2)];
    _line.image = [UIImage imageNamed:@"home_scan_line"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    jobFairId = @"";
}
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50, 100+2*num, kWidth-100, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50, 100+2*num, kWidth-100, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

- (void)setupCamera
{
   
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    [_output setRectOfInterest:CGRectMake((kScanY)/kHeight,((kWidth-kScanWidth)/2)/kWidth,kScanWidth/kHeight,kScanWidth/kWidth)];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,kWidth,kHeight-topBarheight);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [timer invalidate];
    
    NSArray *subArr = [stringValue componentsSeparatedByString:@":"];
    if ([subArr count]==2) {
        NSString *markStr = [subArr firstObject];
        if ([markStr isEqualToString:@"EZZ_FAIR"]) {
            jobFairId = [subArr lastObject];
            //签到请求服务器
            [self requestSign:jobFairId];
            
            
            
        }else if ([markStr isEqualToString:@"EZZ_RES"])
        {
            resumeId = [NSString stringWithFormat:@"%@",[subArr lastObject]] ;
            [self requestResumeCodeStep1];
           
        }else
        {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"请扫描简历或招聘会二维码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alterView.tag = 10;
            [alterView show];
        }
    }else
    {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"请扫描简历或招聘会二维码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alterView.tag = 10;
        [alterView show];
    }

}
#pragma mark - UIAlterViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        [self leftAction];
    }else
    {
        if (buttonIndex==0) {
            [self leftAction];
        }else
        {
            JobFairInfoViewController *infoVC = [[JobFairInfoViewController alloc] init];
            infoVC.jobFairId = jobFairId;
            [self.navigationController pushViewController:infoVC animated:YES];
        }
    }
    
}
#pragma mark - 签到请求服务器
-(void)requestSign:(NSString*)fairID
{
    NSString *listJson = [CombiningData getFairInfoById:fairID Type:kQRCodeSign];
    [self showHUD:@"正在提交签到数据"];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                //签到成功的提示视图
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"签到成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alterView show];


            }else
            {
                NSString *message = [result objectForKey:@"message"];
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil
                    otherButtonTitles:@"确定", nil];
                alterView.tag = 10;
                [alterView show];
//                [self hideHUDFaild:message];
                [self hideHUD];
            }
        }else
        {
//            [self hideHUDFaild:@"服务器请求失败"];
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"服务器请求失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alterView.tag = 10;
            [alterView show];
            [self hideHUD];
        }
        
    }];

}
#pragma mark - 扫描服务器请求服务器
-(void)requestResumeCodeStep1
{
    NSString *listJson = [CombiningData getMineInfo:kQRCodeResumeStep1];
    [self showHUD:@"正在获取数据"];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                //获取该企业招聘列表
                NSArray *arr = [result objectForKey:@"data"];
                if ([arr count]>1) {
                    [self showJobFairListView:arr];
                }else
                {
                    if ([arr count]==1) {
                        NSDictionary *dic = [arr firstObject];
                        [self makeSureAction:[dic objectForKey:@"id"]];
                    }else
                    {
                        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"该企业暂无招聘会" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        alterView.tag = 10;
                        [alterView show];
                    }
                    
               
                }
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil
                                                          otherButtonTitles:@"确定", nil];
                alterView.tag = 10;
                [alterView show];
                [self hideHUD];
            }
        }else
        {
            [self hideHUD];
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"服务器请求失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alterView.tag = 10;
            [alterView show];
        }
    }];
}
-(void)requestResumeCodeStep2:(NSString*)fairId
{
    NSString *listJson = [CombiningData getReceivedResumeByQRCode:fairId ResumeID:resumeId];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                //获取该企业招聘列表
                [self nextResumeInfo];
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil
                                                          otherButtonTitles:@"确定", nil];
                alterView.tag = 10;
                [alterView show];
            }
        }else
        {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"服务器请求失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alterView.tag = 10;
            [alterView show];
        }
    }];
}
#pragma mark - 扫描后显示 招聘会列表
-(void)showJobFairListView:(NSArray*)array
{
    NSArray *arr = nil;
    if (array==nil) {
        arr = [NSArray arrayWithObjects:@"招聘会标题1",@"招聘会标题1", nil];
    }else
    {
        arr = array;
    }
    float viewH = [Util myYOrHeight:35]*[arr count]+[Util myYOrHeight:40]*2;
    float viewY = (kHeight-viewH-topBarheight)/2;
    float viewX = [Util myXOrWidth:10];
    float viewW = kWidth - viewX*2;
    JobFairListView *jobView = [[JobFairListView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH) AndData:arr];
    jobView.delegate = self;
    [jobView showView:self.view];

}
#pragma mark - JobFairListViewDelegate
//取消视图
-(void)cancelAction
{
    [self leftAction];
}
//选择某个招聘会
-(void)makeSureAction:(NSString*)fairId
{
    [self requestResumeCodeStep2:fairId];
}
-(void)nextResumeInfo
{
    ResumeInfoViewController *infoVC = [[ResumeInfoViewController alloc] init];
    infoVC.resumeID = resumeId ;
    infoVC.jobID = @"0";
    //            infoVC.internships = [[Util getCorrectString:[dic objectForKey:@"internships"]] intValue];
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
    NSLog(@"进入简历详情%@",resumeId);

}
#pragma mark -判断照相机是否授权
-(BOOL)enableCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        NSLog(@"相机权限受限");
        
        return NO;
    }
    return YES;
}
@end
