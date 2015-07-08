//
//  CommendView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommendView : UIView
{
    //头像背景视图
    IBOutlet UIView *portraitBg;
    
    //岗位 姓名 专业信息背景
    IBOutlet UIView *infoBg;
}
/**
 加载子视图的数据
 */
-(void)loadSubView:(NSArray*)array;
@end
