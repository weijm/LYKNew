//
//  LoginHeaderView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "LoginHeaderView.h"

@implementation LoginHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"LoginHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        if (kIphone6plus) {
            numberimgHeight.constant = numberimgHeight.constant+3;
            numberimgWidth.constant = numberimgWidth.constant+3;
            passwordimgHeight.constant = passwordimgHeight.constant+3;
            passwordimgWidth.constant = passwordimgWidth.constant+3;
        }
        line1Height.constant = 0.5;
        line2Height.constant = 0.5;
        
        NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kAccount];
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:KPassWord];
        numberTextField.text = account;
        passwordTextField.text = password;
    }
    return self;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(setEditTextField:)]) {
        [_delegate setEditTextField:textField];
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
