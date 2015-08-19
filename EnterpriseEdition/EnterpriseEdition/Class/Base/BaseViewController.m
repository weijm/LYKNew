//
//  BaseViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    
    UIButton *leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBt.frame = frame;
    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-20, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - HUD Methods
//显示提示
- (void)showHUD:(NSString *)title {
    _hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    _hud.labelText = title;
    _hud.dimBackground = YES;
}

//隐藏提示
- (void)hideHUD {
    
    [self.hud hide:YES];
}

//操作完成的提示
- (void)hideHUDWithComplete:(NSString *)title  //隐藏之前显示操作完成的提示
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式为自定义视图模式
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
    
    //延迟隐藏
    [self.hud hide:YES afterDelay:0.5f];
}
//数据请求错误提示
- (void)hideHUDFaild:(NSString *)title
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colse.png"]];
    //显示模式为自定义视图模式
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
    
    //延迟隐藏
    [self.hud hide:YES afterDelay:0.5f];
}
- (void)showAlertView:(NSString *)alertTitle
{
    UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:alertTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertV show];
}


@end
