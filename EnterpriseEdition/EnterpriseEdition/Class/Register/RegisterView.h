//
//  RegisterView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView
{
    
    IBOutlet UITextField *numberTextField;
    IBOutlet UITextField *codeTextField;
    
    IBOutlet UIButton *codeBt;
    
    int second;
}
/**
 取消键盘
 */
-(void)cancelKeyBoard;
/**
 获取验证码
 */
- (IBAction)getCode:(id)sender;
- (void)nextStep:(id)sender;

@end
