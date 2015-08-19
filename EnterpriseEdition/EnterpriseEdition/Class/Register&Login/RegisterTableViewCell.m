//
//  RegisterTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/25.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterTableViewCell.h"

@implementation RegisterTableViewCell

- (void)awakeFromNib {
    // Initialization code
    seconds = 60;
    lineHeight.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadSubView:(NSString*)contentString
{
    contentTextField.tag = self.tag;
    
    switch (self.tag) {
        case 0:
        {
            if (_cellType == 2) {//设置密码页面 手机号直接显示
                titleLab.text = @"手 机 号";
                contentTextField.userInteractionEnabled = NO;
                NSMutableString *phone = [[NSMutableString alloc] initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kRegisterAccount]];
                NSRange range = NSMakeRange(3,4);
                [phone replaceCharactersInRange:range withString:@"****"];
                
                contentTextField.text = phone;
            }else
            {
                titleLab.text = @"手 机 号";
                if (_cellType == 1) {//忘记密码页面手机号的提示语
                    contentTextField.placeholder = @"请输入登录手机号";
                }else
                {
                    contentTextField.placeholder = @"手机号11位数字，不能含有字母";
                }
                contentTextField.keyboardType = UIKeyboardTypeNumberPad;
                contentTextField.userInteractionEnabled = YES;
            }
        }
            
            break;
        case 1:
            if (_cellType == 0||_cellType == 2) {//注册页和设置密码页 显示设置密码
                titleLab.text = @"设置密码";
                contentTextField.placeholder = @"6-16位数字和字母组合";
                contentTextField.secureTextEntry = YES;
                break;
            }
            //忘记密码页 直接走获取验证码的cell
        case 3:
        {
            if (_cellType == 2) {//设置密码页 显示确认按钮
                [self initButton];
            }else
            {//其他的显示获取验证码的cell
                codeTextField.tag = 3;
                bg.hidden = YES;
                codeBg.hidden = NO;
                timesLab.hidden = YES;
                //监听停止计时器
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopCodeTimer) name:@"CodeTimer" object:nil];
            }
        }
            break;
        case 2:
            if (_cellType ==0 ||_cellType==2) {//注册页和设置密码页 显示确认密码
                titleLab.text = @"确认密码";
                contentTextField.placeholder = @"6-16位数字和字母组合";
                contentTextField.secureTextEntry = YES;
                
                break;
            }
            //忘记密码页 直接走下一步按钮的cell
        case 4:
        {
            [self initButton];
        }
            
            break;
      
        default:
            break;
    }
    if (_cellType ==2 && self.tag ==0) {
        //设置密码页的手机号不可编辑
    }else
    {
        if ([contentString length]>0) {
            contentTextField.text = contentString;
            codeTextField.text = contentString;
        }
    }
}
-(void)initButton
{
    codeBg.hidden = YES;
    hline.hidden = YES;
    titleLab.hidden = YES;
    contentTextField.hidden = YES;
    CGRect frame = CGRectMake(-15,[Util myYOrHeight:80]-[Util myYOrHeight:35] , kWidth-30, [Util myYOrHeight:30]);
    //登录按钮
    UIButton *nextBt = [[UIButton alloc] initWithFrame:frame];
    nextBt.backgroundColor = Rgb(2, 139, 230, 1.0);
    if (_cellType == 2) {
        [nextBt setTitle:@"确认提交" forState:UIControlStateNormal];
    }else
    {
        [nextBt setTitle:@"下 一 步" forState:UIControlStateNormal];
    }
    
    nextBt.tag =1;
    [nextBt addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    nextBt.layer.cornerRadius = 3.0;
    nextBt.layer.masksToBounds = YES;
    [bg addSubview:nextBt];
    
}
- (IBAction)getCodeTimes:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(cancelKey)]) {
        [_delegate cancelKey];
    }

    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kRegisterAccount];
    //判断手机号是否正确
    if ([Util checkTelephone:phone]) {
        //手机号正确 视图倒计时
        codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        
        codeBt.enabled = NO;
        codeMarkLab.hidden = YES;
        timesLab.hidden = NO;
        
        // 从服务器获取验证码
        if ([_delegate respondsToSelector:@selector(getCode)]) {
            [_delegate getCode];
        }
        
    }
    
    
}
//倒计时
-(void)countDown
{
    seconds--;
    timesLab.text = [NSString stringWithFormat:@"%d秒后可重新获取",seconds];
    if (seconds == 0) {
        //终止计时器
        if (codeTimer) {
            [codeTimer invalidate];
            codeTimer = nil;
        }
        //获取验证码按钮可点
        codeBt.enabled = YES;
        //显示时间的lab
        timesLab.text = @"60秒后可重新获取";
        seconds = 60;
        codeMarkLab.hidden = NO;
        timesLab.hidden = YES;
        
    }
}
//停止计时器
-(void)stopCodeTimer
{
    if (codeTimer) {
        //终止计时器
        [codeTimer invalidate];
        codeTimer = nil;
    }
    
    //获取验证码按钮可点
    codeBt.enabled = YES;
    //显示时间的lab
    timesLab.text = @"60秒后可重新获取";
    
    codeMarkLab.hidden = NO;
    timesLab.hidden = YES;
    
}
//下一步
-(void)nextAction
{
    if ([_delegate respondsToSelector:@selector(clickedNextBtAction)]) {
        [_delegate clickedNextBtAction];
    }
}
#pragma mark - 向服务器请求获取验证码

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if ([_delegate respondsToSelector:@selector(setEditView:)]) {
        textField.tag = self.tag;
        [_delegate setEditView:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(cancelKey)]) {
        [_delegate cancelKey];
    }
    return YES;
}

@end
