//
//  FooterView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/11.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterView : UIView
{
    
    IBOutlet UIView *subView;
}
@property (nonatomic,copy)void(^chooseFooterBtAction)(NSInteger index);
/**
 设置按钮可点击或不可点击
 */
-(void)setButton:(NSArray*)array Enable:(BOOL)isEnable;
/**
 显示footerView
 */
-(void)showFooterView:(UIView*)supview;
/**
 取消footerView
 */
-(void)cancelFooterView;
@end
