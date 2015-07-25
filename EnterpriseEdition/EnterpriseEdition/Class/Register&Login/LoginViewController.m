//
//  LoginViewController.m
//  登录页面
//
//  Created by wjm on 15/7/7.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "LoginViewController.h"

#import "LoginHeaderView.h"

@interface LoginViewController ()
{
    LoginHeaderView *loginView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    
    self.title = @"登录";
    CGRect frame = CGRectMake(0, topBarheight, kWidth, [Util myYOrHeight:120]);
    //初始化编辑视图
    loginView = [[LoginHeaderView alloc] initWithFrame:frame];
    [self.view addSubview:loginView];
    //初始化按钮视图
    [self initButton];
    
    //取消键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark - 取消键盘
-(void)cancelKey
{
//    [loginView cancelKeyBoard];
}
#pragma mark - 初始化登录按钮和忘记密码
-(void)initButton
{
    float btY = loginView.frame.origin.y + loginView.frame.size.height+[Util myYOrHeight:20];
    CGRect frame = CGRectMake(10,btY , kWidth-20, [Util myYOrHeight:40]);
    //登录按钮
    UIButton *loginBt = [[UIButton alloc] initWithFrame:frame];
    loginBt.backgroundColor = Rgb(16, 117, 224, 1.0);
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    loginBt.tag =1;
    [loginBt addTarget:self action:@selector(clickedBtAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBt.layer.cornerRadius = 5.0;
    loginBt.layer.masksToBounds = YES;
    [self.view addSubview:loginBt];
    
    //忘记密码按钮
    float btW = [Util myXOrWidth:100];
    btY = frame.origin.y+frame.size.height+[Util myYOrHeight:15];
    frame = CGRectMake((kWidth-btW)/2, btY, btW, [Util myYOrHeight:30]);
    UIButton *forgetBt = [[UIButton alloc] initWithFrame:frame];
    [forgetBt setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBt.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBt setTitleColor:Rgb(254, 156, 50,1.0) forState:UIControlStateNormal];
    forgetBt.tag = 2;
    [forgetBt addTarget:self action:@selector(clickedBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBt];
}
#pragma mark - 登录按钮和忘记密码的点击事件
-(void)clickedBtAction:(id)sender
{
    UIButton *bt = (UIButton*)sender;
    NSInteger index = bt.tag;
    if (index == 1) {
        NSLog(@"登录");
    }else
    {
        NSLog(@"忘记密码");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
