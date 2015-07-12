//
//  ResumeChooseBtView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIButton_Custom;
@interface ResumeChooseBtView : UIView
{
    IBOutlet UIView *vline;
    
}
@property (strong, nonatomic) IBOutlet UIButton_Custom *chooseBt;

@property(nonatomic,copy) void (^clickedBtAction)(NSInteger index);
/**
 点击事件
 */
- (IBAction)clickedAction:(id)sender;
/**
 初始化按钮
 */
-(void)loadSubView;
/**
 初始化底部视图上的按钮
 */
-(void)loadFooterSubView;
@end
