//
//  RegisterView.h
//  注册和登录页面的编辑部分视图
//
//  Created by wjm on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView<UITextFieldDelegate>
{
    
    IBOutlet UITextField *numberTextField;
    IBOutlet UITextField *codeTextField;
    
    IBOutlet UIButton *codeBt;
    
    int second;//60s计时
    //账号label  注册-手机号登录- 账号
    
    IBOutlet UILabel *numberLab;
   
    //注册-验证码 登录 - 密码
    
    IBOutlet UILabel *codeLab;
    //注册竖线和codeBt显示 否则隐藏
    
    IBOutlet UIView *vLine;
    
    NSInteger mark; //0：注册  1：登录
}

/**
 取消键盘
 */
-(void)cancelKeyBoard;
/**
 获取验证码
 */
- (IBAction)getCode:(id)sender;
/**
 下一步的触发事件
 */
- (BOOL)nextStep;
/**
 登录页面加载子视图
 */
-(void)loadSubView;

@end
