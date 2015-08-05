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
    __weak IBOutlet UIImageView *protraitImg;
    //匹配度label
    __weak IBOutlet UILabel *rateLab;
    //岗位
    __weak IBOutlet UILabel *jobLab;
    
    //姓名
    __weak IBOutlet UILabel *nameLab;
    //专业
    __weak IBOutlet UILabel *proLab;
    __weak IBOutlet NSLayoutConstraint *protraitimgWidth;
    
    __weak IBOutlet NSLayoutConstraint *protraitimgHeight;
    
    __weak IBOutlet NSLayoutConstraint *protraitToTop;
    
    __weak IBOutlet NSLayoutConstraint *rateHeight;

    __weak IBOutlet NSLayoutConstraint *rateWidth;
    __weak IBOutlet NSLayoutConstraint *infoBgToTop;
}
/**
 初始化子视图数据
 */
-(void)loadSubView:(NSDictionary*)dictionary;
@end
