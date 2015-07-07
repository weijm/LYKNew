//
//  RegisterView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/6.
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
- (void)nextStep:(id)sender {
    BOOL isCorrect = [self checkString:YES];//需要检查验证码是否填写
    if (isCorrect) {//手机号和验证码填写正确
        
    }
    
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
@end
