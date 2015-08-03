//
//  LoginViewController.h
//  登录页面
//
//  Created by wjm on 15/7/7.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginHeaderView.h"
@protocol LoginViewControllerDelegate<NSObject>
-(void)loginSuccess;
@end
@interface LoginViewController : BaseViewController<LoginHeaderViewDelegate>
@property(nonatomic,weak) id<LoginViewControllerDelegate>delegate;
@end
