//
//  RegisterView.m
//  注册和登录页面的编辑部分视图
//
//  Created by wjm on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"RegisterView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        second = 60;
    }
    return self;
}
#pragma mark - 取消键盘
-(void)cancelKeyBoard
{
    [numberTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
}
#pragma mark - 获取验证码
- (IBAction)getCode:(id)sender {
    [self cancelKeyBoard];
    BOOL isCorrect = [self checkString:NO];//不需要校验验证码
    if (isCorrect) {//正确做的处理
        [NSTimer  scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
    }
}
#pragma mark - 下一步的触发事件
- (BOOL)nextStep {
//    BOOL isCorrect = [self checkString:YES];//需要检查验证码是否填写
//    if (isCorrect) {//yes手机号和验证码填写正确 no 不正确
//        [[NSUserDefaults standardUserDefaults] setObject:numberTextField.text forKey:@"account"];
//    }
    //测试设置的值
    BOOL isCorrect  = YES;
    [[NSUserDefaults standardUserDefaults] setObject:numberTextField.text forKey:@"account"];
    return isCorrect;
}
#pragma makr - 验证textField中得字符窜
-(BOOL)checkString:(BOOL)isCode
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"请输入"];
    
    BOOL isCorrect = YES;
    //判断手机号是否为空
    if ([numberTextField.text length]==0) {
        [string appendFormat:@"手机号 "];
        isCorrect = NO;
    }else
    {
        //判断手机号格式是否正确
        if (![Util isMobileNumber:numberTextField.text]) {
            [string appendFormat:@"正确的手机号 "];
            isCorrect = NO;
        }
    }
    // 是否需要校验验证码
    if (isCode) {
        //判断验证码是否为空
        if ([codeTextField.text length]==0) {
            [string appendFormat:@"验证码"];
            isCorrect = NO;
        }
    }
    
    //填写内容不正确时，窗口提示
    if (!isCorrect) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
    }
    
    return isCorrect;
}
#pragma mark - 60s计时
- (void)timerAdvanced:(NSTimer *)timer
{
    [codeBt setTitle:[NSString stringWithFormat:@"%d秒后重新获取",second] forState:UIControlStateNormal];
    second--;
    if (second == 0) {
        [timer invalidate];
        timer = nil;
    }
    
}
#pragma mark - 登录页面加载子视图
-(void)loadSubView
{
    //将密码的输入框大小设置的和账号的一样
    CGRect frame = codeTextField.frame;
    frame.size.width = numberTextField.frame.size.width;
    codeTextField.frame = frame;
    UIView *supperView = [codeTextField superview];
    [supperView addSubview:codeTextField];
    //标记为登录
    mark = 1;
    //修改标题
    numberLab.text = @"账号";
    codeLab.text = @"密码";
    
    //修改编辑框提示语
    numberTextField.placeholder = @"请输入账号";
    codeTextField.placeholder = @"请输入密码";
    
    //隐藏不需要的视图
    vLine.hidden = YES;
    codeBt.hidden = YES;
    
    //设置密码安全输入
    codeTextField.secureTextEntry = YES;
    
}
#pragma mark -UITextFiled
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
@end
