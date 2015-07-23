//
//  PositionOperationView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionOperationView : UIView

@property (nonatomic,copy) void(^operationPosition)(int index);
/**
 显示视图
 */
-(void)showView:(UIView *)view;
/**
 取消视图
 */
-(void)cancelView;
/**
 操作按钮的触发事件
 */
- (IBAction)operationPositionAction:(id)sender;

@end
