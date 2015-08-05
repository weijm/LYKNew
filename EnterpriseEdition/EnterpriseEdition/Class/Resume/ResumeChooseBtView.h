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
    __weak IBOutlet UIView *vline;
   
    
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
 初始化急招中的按钮
 */
-(void)loadSubViewInNowHiring;

/**
 初始化底部视图上的按钮
 */
-(void)loadFooterSubView;

/**
 初始化职位底部视图上的按钮
 */
-(void)loadPositionFooterSubView;

/**
 初始化职位详情底部视图上的按钮
 */
-(void)loadPositionInfoFooterSubView;

/**
 初始化信息底部视图上的按钮
 */
-(void)loadInfoInfoFooterSubView;
/**
 初始化认领职位底部视图上的按钮
 */
-(void)loadClaimPositionFooterView;
/**
 初始化职位中的按钮
 */
-(void)loadSubViewInPosition;
@end
