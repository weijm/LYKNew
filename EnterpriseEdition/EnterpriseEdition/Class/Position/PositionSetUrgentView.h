//
//  PositionSetUrgentView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButton_Custom;
@interface PositionSetUrgentView : UIView
{
    
    IBOutlet UIButton_Custom *chooseBt1;
    
    IBOutlet UIButton_Custom *chooseBt2;
    IBOutlet UIButton_Custom *chooseBt3;
    
    int  positionCount;
    
    IBOutlet UILabel *proLab;
    
}
@property (nonatomic,copy) void(^makeSurePositionUrgent)(int count);
/**
 显示视图
 */
-(void)showView:(UIView *)view;
/**
 取消视图
 */
-(void)cancelView;
/**
 确认的点击事件
 */
- (IBAction)makeSure:(id)sender;
/**
 选择简历个数的触发事件
 */
- (IBAction)chooseCountAction:(id)sender;
/**
 关闭事件
 */
- (IBAction)closeAction:(id)sender;

@end
