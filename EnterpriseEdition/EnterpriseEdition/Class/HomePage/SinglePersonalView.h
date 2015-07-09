//
//  SinglePersonalView.h
//  单个人的信息介绍视图
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePersonalView : UIView
{
    //头像
    IBOutlet UIImageView *protraitImg;
    //匹配度label
    IBOutlet UILabel *rateLab;
    //岗位
    IBOutlet UILabel *jobLab;
    
    //姓名
    IBOutlet UILabel *nameLab;
    //专业
    IBOutlet UILabel *proLab;
}
/**
 初始化子视图数据
 */
-(void)loadSubView:(NSDictionary*)dictionary;
@end
