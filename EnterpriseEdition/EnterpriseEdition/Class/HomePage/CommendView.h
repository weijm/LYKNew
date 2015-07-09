//
//  CommendView.h
//  推荐部分的视图
//
//  Created by lyk on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommendView : UIView
{
  
    //个人信息背景
    IBOutlet UIView *bottombg;
}
@property(nonatomic,copy) void(^clickPersonalInfo)(NSInteger index);
/**
 加载子视图的数据
 */
-(void)loadSubView:(NSArray*)array;
/**
 查看更多
 */
- (IBAction)clickedMoreBt:(id)sender;

@end
