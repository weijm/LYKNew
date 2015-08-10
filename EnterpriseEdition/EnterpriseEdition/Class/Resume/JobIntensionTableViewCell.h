//
//  JobIntensionTableViewCell.h
//  求职意向Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleView;

@interface JobIntensionTableViewCell : UITableViewCell
{
    
    __weak IBOutlet TitleView *titleView;

    //内容为空时展示
    __weak IBOutlet UITextField *emptyView;
    //期望行业
    __weak IBOutlet UILabel *industryLab;
    //期望职位
    
    __weak IBOutlet UILabel *jobLab;
    //职位类型
    
    __weak IBOutlet UILabel *jobTypeLab;
    //期望城市

    __weak IBOutlet UILabel *cityLab;
    //期望薪资
    
    __weak IBOutlet UILabel *salaryLab;
    
    
    __weak IBOutlet UIView *infoBg;
    
}
-(void)loadData:(NSObject*)object;
@end
