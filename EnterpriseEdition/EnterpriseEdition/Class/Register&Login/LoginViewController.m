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
#import "RootViewController.h"



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

    self.title = @"登 录";
    
    [self initRightItems];
    
    CGRect frame = CGRectMake(0, topBarheight+[Util myYOrHeight:30], kWidth, [Util myYOrHeight:93]);
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
//    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kAccount];
//    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:KPassWord];
//    if ([account length]>0) {
//        [contentArray replaceObjectAtIndex:0 withObject:account];
//    }
//    if ([password length]>0) {
//        [contentArray replaceObjectAtIndex:1 withObject:password];
//    }
    
}
-(void)setPhoneAndPsw
{
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kAccount];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:KPassWord];
    if ([account length]>0) {
        [contentArray replaceObjectAtIndex:0 withObject:account];
    }
    if ([password length]>0) {
        [contentArray replaceObjectAtIndex:1 withObject:password];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [self setPhoneAndPsw];
    [loginView reloadTextField];
}
#pragma mark - 初始化登录按钮和忘记密码
-(void)initButton
{
    float btY = loginView.frame.origin.y + loginView.frame.size.height+[Util myYOrHeight:30];
    CGRect frame = CGRectMake(15,btY , kWidth-30, [Util myYOrHeight:30]);
    //登录按钮
    UIButton *loginBt = [[UIButton alloc] initWithFrame:frame];
    loginBt.backgroundColor = Rgb(2, 139, 230, 1.0);
    [loginBt setTitle:@"登  录" forState:UIControlStateNormal];
    loginBt.tag =1;
    [loginBt addTarget:self action:@selector(clickedBtAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBt.layer.cornerRadius = 3.0;
    loginBt.layer.masksToBounds = YES;
    [self.view addSubview:loginBt];
    
    //忘记密码按钮
    float btW = [Util myXOrWidth:100];
    btY = frame.origin.y+frame.size.height+[Util myYOrHeight:10];
    frame = CGRectMake((kWidth-btW)/2, btY, btW, [Util myYOrHeight:30]);
    UIButton *forgetBt = [[UIButton alloc] initWithFrame:frame];
    [forgetBt setTitle:@"忘记密码?" forState:UIControlStateNormal];
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
            [self editTextFiledAndCancelKey:YES];
        }

        if (kTestType) {//测试 不要登录页面
            //将登录页面取消
            [self dismissViewControllerAnimated:YES completion:nil];
            //加载首页数据
            if ([_delegate respondsToSelector:@selector(loginSuccess)]) {
                [_delegate loginSuccess];
            }
            return;
        }
                NSString *phone = [contentArray firstObject];
        if ([Util checkTelephone:phone]) {
            NSString *password = [contentArray lastObject];
            if ([Util checkPassWord:password]) {
                //将账号和密码存在本地
                [self requestLogin:phone password:password];
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
-(void)dismissLoginView
{
    //将登录页面取消
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 服务器请求
-(void)requestLogin:(NSString*)userName password:(NSString*)password
{
    [self showHUD:@"正在登录"];
    NSString *loginJson = [CombiningData loginUser:userName Password:password];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:loginJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUDWithComplete:@"登录成功"];
                
                
                //加载首页数据
                if ([_delegate respondsToSelector:@selector(loginSuccess)]) {
                    [_delegate loginSuccess];
                }
                //将用户ID 企业ID进行存储
                 NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                NSArray *dataArr = [result objectForKey:@"data"];
                if ([dataArr count]>0) {
                    NSDictionary * resultDic = [dataArr firstObject];
                     NSString *uid = [resultDic objectForKey:@"uid"];
                    NSString *iid = [resultDic objectForKey:@"info_id"];
                    [userDefault setObject:uid forKey:kUID];
                    [userDefault setObject:iid forKey:KIID];
                    [userDefault setObject:[Util getCorrectString:[resultDic objectForKey:@"status"]] forKey:kEntStatus];
                }
                //标记是否登录成功
                [userDefault setObject:@"1" forKey:kLoginOrExit];
               
                [userDefault setObject:userName forKey:kAccount];
                [userDefault setObject:password forKey:KPassWord];
                [userDefault synchronize];
                [self performSelector:@selector(dismissLoginView) withObject:nil afterDelay:1.5];
            }else
            {
                [self hideHUD];
                [Util showPrompt:[result objectForKey:@"message"]];
            }
        }else
        {
            [self hideHUD];
            [self showAlertView:@"服务器请求失败"];
            NSLog(@"%@",error);
        }
        
    };
    
    
}
#pragma mark - 编辑按钮
-(void)initRightItems
{
    self.navigationItem.leftBarButtonItem = nil;
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setTitle:@"注册" forState:UIControlStateNormal];
    if (kIphone4||kIphone5) {
        rightBt.titleLabel.font = [UIFont systemFontOfSize:13];
    }else
    {
        rightBt.titleLabel.font = [UIFont systemFontOfSize:15];
    }
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
        }else
        {
            [contentArray replaceObjectAtIndex:currentTextField.tag withObject:@"0"];
        }
    }
    
}

@end
