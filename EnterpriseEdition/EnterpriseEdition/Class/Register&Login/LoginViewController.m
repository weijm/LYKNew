//
//  LoginViewController.m
//  登录页面
//
//  Created by wjm on 15/7/7.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterUserViewController.h"
#import "ForgetPasswordViewController.h"



@interface LoginViewController ()
{
    LoginHeaderView *loginView;
    
    UITextField *currentTextField;
    
    NSMutableArray *contentArray;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    
    self.title = @"登 录";
    
    [self initItems];
    
    CGRect frame = CGRectMake(0, topBarheight+[Util myYOrHeight:30], kWidth, [Util myYOrHeight:100]);
    //初始化编辑视图
    loginView = [[LoginHeaderView alloc] initWithFrame:frame];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    //初始化按钮视图
    [self initButton];
    
    //取消键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
    [self.view addGestureRecognizer:tap];
    
    contentArray = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
}

#pragma mark - 初始化登录按钮和忘记密码
-(void)initButton
{
    float btY = loginView.frame.origin.y + loginView.frame.size.height+[Util myYOrHeight:45];
    CGRect frame = CGRectMake(15,btY , kWidth-30, [Util myYOrHeight:35]);
    //登录按钮
    UIButton *loginBt = [[UIButton alloc] initWithFrame:frame];
    loginBt.backgroundColor = Rgb(16, 117, 224, 1.0);
    [loginBt setTitle:@"登  录" forState:UIControlStateNormal];
    loginBt.tag =1;
    [loginBt addTarget:self action:@selector(clickedBtAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBt.layer.cornerRadius = 3.0;
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
        if (currentTextField) {
            [self editTextFiledAndCancelKey:NO];
        }
        NSString *phone = [contentArray firstObject];
        if ([Util checkTelephone:phone]) {
            NSString *password = [contentArray lastObject];
            if ([Util checkPassWord:password]) {
                NSLog(@"账号密码 格式正确 请求服务器");
            }
        }
    }else
    {
        NSLog(@"忘记密码");
        ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setTitle:@"注册" forState:UIControlStateNormal];
    rightBt.titleLabel.font = [UIFont systemFontOfSize:15];
    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+15, titleInsets.bottom, titleInsets.right-15);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)rightAction
{
    RegisterUserViewController *registerVC = [[RegisterUserViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark -LoginHeaderViewDelegate
-(void)setEditTextField:(UITextField *)_textField
{
    [self editTextFiledAndCancelKey:NO];
    currentTextField = _textField;
}
-(void)cancelKey
{
    [self editTextFiledAndCancelKey:YES];
    currentTextField = nil;
}
-(void)editTextFiledAndCancelKey:(BOOL)isCancel
{
    if (currentTextField) {
        if (isCancel) {
            [currentTextField resignFirstResponder];
        }
        NSString *content = currentTextField.text;
        if ([content length]>0) {
            [contentArray replaceObjectAtIndex:currentTextField.tag withObject:content];
        }
    }
    
}

@end
