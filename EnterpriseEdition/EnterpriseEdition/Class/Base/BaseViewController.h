//
//  BaseViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController
{
//    UIView   *topbj_View;
//    UIButton *back_bt;
//    UILabel  *base_label;
//    UIView   *top_view;
//    UIView   *mask_view;
//    UIImageView * backImage;
}
@property (nonatomic, readonly) MBProgressHUD *hud;

//显示hud加载提示
- (void)showHUD:(NSString *)title;
//两种隐藏hud的方式
- (void)hideHUD;  //直接隐藏
- (void)hideHUDWithComplete:(NSString *)title;  //隐藏之前显示操作完成的提示
//数据请求错误提示
- (void)hideHUDFaild:(NSString *)title;
- (void)showAlertView:(NSString *)alertTitle;
@end
