//
//  RegisterSuccessViewController.m
//  注册成功页面
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterSuccessViewController.h"

@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册成功";
    self.view.backgroundColor = Rgb(230, 244, 253, 1.0);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressBtAction:(id)sender {
}
@end
