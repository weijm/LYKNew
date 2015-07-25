//
//  RegisterUserViewController.m
//  注册
//
//  Created by wjm on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterUserViewController.h"
#import "RegisterView.h"
#import "RegisterBottomView.h"
#import "LoginViewController.h"
#import "CreateUserViewController.h"

@interface RegisterUserViewController ()
{
    RegisterView *registerView;
}
@end

@implementation RegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    
    //登录入口
    UIButton *rightBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightBt setTitle:@"登录" forState:UIControlStateNormal];
    [rightBt setTitleColor:Rgb(255, 149, 121,1.0) forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //初始化子页面
    [self initSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 初始化注册页面
-(void)initSubView
{
    //注册编辑视图
    CGRect frame = CGRectMake(0, topBarheight, kWidth, [Util myYOrHeight:120]);
    registerView =[[RegisterView alloc] initWithFrame:frame];
    [self.view addSubview:registerView];
    
    //初始化下一步按钮及协议
    float bottomY = frame.origin.y+frame.size.height+[Util myYOrHeight:30];
    frame = CGRectMake(0, bottomY, kWidth, [Util myYOrHeight:100]);
    RegisterBottomView *bottomView = [[RegisterBottomView alloc] initWithFrame:frame];
    bottomView.clickedAction = ^(int index){
        if (index == 0) {//查看协议
            [self lookUpAgreement];
        }else
        {//下一步
            BOOL isCorrect = [registerView nextStep];
            if (isCorrect) {
                [self nextAction];
            }
        }
    };
    [self.view addSubview:bottomView];
    
    //取消键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark - 进入登陆页面
-(void)login
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
#pragma mark - 取消键盘
-(void)cancelKey
{
    [registerView cancelKeyBoard];
}
#pragma mark - 查看协议
-(void)lookUpAgreement
{
    NSLog(@"查看协议");
}
#pragma mark - 下一步的触发事件
-(void)nextAction
{
    CreateUserViewController *createVC = [[CreateUserViewController alloc] init];
    [self.navigationController pushViewController:createVC animated:YES];
}
@end
