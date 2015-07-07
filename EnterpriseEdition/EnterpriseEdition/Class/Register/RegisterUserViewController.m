//
//  RegisterUserViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterUserViewController.h"
#import "RegisterView.h"
#import "RegisterBottomView.h"

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
    //注册编辑视图
    CGRect frame = CGRectMake(0, topBarheight, kWidth, [Util myYOrHeight:120]);
    registerView =[[RegisterView alloc] initWithFrame:frame];
    [self.view addSubview:registerView];
    
    //初始化下一步按钮及协议
    float bottomY = [Util myYOrHeight:frame.origin.y+frame.size.height+30];
    frame = CGRectMake(0, bottomY, kWidth, 100);
    RegisterBottomView *bottomView = [[RegisterBottomView alloc] initWithFrame:frame];
    bottomView.clickedAction = ^(int index){
        if (index == 0) {//查看协议
            [self lookUpAgreement];
        }else
        {//下一步
            [registerView nextStep:nil];
        }
        
    };
    [self.view addSubview:bottomView];
    
    //取消键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
    [self.view addGestureRecognizer:tap];
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
@end
