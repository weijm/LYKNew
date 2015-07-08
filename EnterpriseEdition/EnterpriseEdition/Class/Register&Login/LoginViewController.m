//
//  LoginViewController.m
//  登录页面
//
//  Created by wjm on 15/7/7.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterView.h"

@interface LoginViewController ()
{
    RegisterView *loginView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    CGRect frame = CGRectMake(0, topBarheight, kWidth, [Util myYOrHeight:120]);
    
    //初始化编辑视图
    loginView = [[RegisterView alloc] initWithFrame:frame];
    [loginView loadSubView];
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
    [loginView cancelKeyBoard];
}
#pragma mark - 初始化登录按钮和忘记密码
-(void)initButton
{
    float btY = loginView.frame.origin.y + loginView.frame.size.height+[Util myYOrHeight:20];
    CGRect frame = CGRectMake(0,btY , kWidth, [Util myYOrHeight:40]);
    //登录按钮
    UIButton *loginBt = [[UIButton alloc] initWithFrame:frame];
    loginBt.backgroundColor = [UIColor lightGrayColor];
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    loginBt.tag =1;
    [loginBt addTarget:self action:@selector(clickedBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBt];
    
    //忘记密码按钮
    float btW = [Util myXOrWidth:100];
    btY = frame.origin.y+frame.size.height+[Util myYOrHeight:10];
    frame = CGRectMake((kWidth-btW)/2, btY, btW, [Util myYOrHeight:30]);
    UIButton *forgetBt = [[UIButton alloc] initWithFrame:frame];
    [forgetBt setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBt.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBt setTitleColor:Rgb(255, 149, 121,1.0) forState:UIControlStateNormal];
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
