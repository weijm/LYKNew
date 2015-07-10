//
//  CellMiddleView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMiddleView : UIView
{
    //头像
    IBOutlet UIImageView *protraitImg;
    //工作经验
    
    IBOutlet UILabel *experienceLab;
    //名字那行
    IBOutlet UILabel *firstLab;
    
    //年龄那行
    IBOutlet UILabel *secondLab;
    
    //专业那行
    IBOutlet UILabel *thirdLab;
}
/**
 加载数据
 */
-(void)loadData:(NSDictionary *)dictionary;
@end
