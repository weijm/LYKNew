//
//  RootViewController.h
//   首页
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h";
@interface RootViewController : UITabBarController<LoginViewControllerDelegate>
@property (nonatomic,strong) LoginViewController *loginVC;
@end
