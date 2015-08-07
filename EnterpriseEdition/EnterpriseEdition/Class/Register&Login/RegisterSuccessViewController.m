//
//  RegisterSuccessViewController.m
//  注册成功页面
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "EnterpriseInfoViewController.h"

@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册成功";
    self.view.backgroundColor = kCVBackgroundColor;
    infoBt.layer.cornerRadius = 5;
    infoBt.layer.masksToBounds = YES;
    
    randomBt.layer.cornerRadius = 5;
    randomBt.layer.masksToBounds = YES;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.0823, 0.545, 0.902, 1 });
    randomBt.layer.borderColor = colorref;
    randomBt.layer.borderWidth = 1.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressBtAction:(id)sender {
    UIButton *bt = (UIButton*)sender;
    if (bt.tag == 1) {//填写企业资料
        EnterpriseInfoViewController *enterpriseVC = [[EnterpriseInfoViewController alloc] init];
        [self.navigationController pushViewController:enterpriseVC animated:YES];
    }else
    {//随便看看
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOrExit object:@"0"];
    }
}
@end
