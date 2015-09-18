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
#define kScanWidth [Util myXOrWidth:250]
#define kScanY [Util myYOrHeight:80]
@interface ScanCodeViewController ()

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"二维码扫描";
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    float imgW = kScanWidth;
    float imgX = (kWidth-imgW)/2;
    float imgY = kScanY;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imgX,imgY ,imgW,imgW)];
    imageView.image = [UIImage imageNamed:@"home_pick_bg"];
    [self.view addSubview:imageView];
    
    //遮罩视图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, imgY)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8;
    [self.view addSubview:bgView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, imgY, imgX, imgW)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8;
    [self.view addSubview:bgView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(imgX+imgW, imgY, imgX, imgW)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8;
    [self.view addSubview:bgView];
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, imgY+imgW, kWidth, kHeight-(imgY+imgW+topBarheight))];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8;
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
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
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
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"签到成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alterView show];
            
            
            
        }else if ([markStr isEqualToString:@"EZZ_RES"])
        {
            ResumeInfoViewController *infoVC = [[ResumeInfoViewController alloc] init];
            infoVC.resumeID = [NSString stringWithFormat:@"%@",[subArr lastObject]] ;
            infoVC.jobID = @"0";
//            infoVC.internships = [[Util getCorrectString:[dic objectForKey:@"internships"]] intValue];
            infoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:infoVC animated:YES];
            NSLog(@"进入简历详情%@",[subArr lastObject]);
        }else
        {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"扫描的二维码格式错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alterView.tag = 10;
            [alterView show];
        }
    }else
    {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"扫描的二维码格式错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alterView.tag = 10;
        [alterView show];
    }

}
#pragma mark -
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

@end
