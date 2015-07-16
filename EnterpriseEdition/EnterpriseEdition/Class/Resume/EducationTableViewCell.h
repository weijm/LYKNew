//
//  EducationTableViewCell.h
//  教育背景Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleView;
@interface EducationTableViewCell : UITableViewCell
{
    
    IBOutlet TitleView *titleView;
    //数据为空的情况显示
    IBOutlet UITextField *emptyView;
}
@end
