//
//  ScanCodeViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/9/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ScanCodeViewController.h"

@interface ScanCodeViewController ()

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"二维码扫描";
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    float imgW = [Util myXOrWidth:250];
    float imgX = (kWidth-imgW)/2;
    float imgY = [Util myYOrHeight:80];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imgX,imgY ,imgW,imgW)];
    imageView.image = [UIImage imageNamed:@"home_pick_bg"];
    [self.view addSubview:imageView];
    
    //遮罩视图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, imgY)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, imgY, imgX, imgW)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(imgX+imgW, imgY, imgX, imgW)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, imgY+imgW, kWidth, kHeight-(imgY+imgW+topBarheight))];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];


    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(imgX, imgY+imgW+[Util myYOrHeight:10], imgW, 50)];
    labIntroudction.font = [UIFont systemFontOfSize:14];
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
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [timer invalidate];
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
    [self leftAction];
    [Util showPrompt:stringValue];
//    [self dismissViewControllerAnimated:YES completion:^
//     {
//        
//     }];
}


@end
