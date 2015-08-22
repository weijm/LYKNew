//
//  CellHeaderView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CellHeaderView : UIView
{
    __weak IBOutlet UILabel *jobTitLab;
    //应聘岗位
    __weak IBOutlet UILabel *jobLab;
    
    
    //时间
    __weak IBOutlet UILabel *timeLab;
    //匹配度视图
    __weak IBOutlet UIView *rateView;
    
    //匹配度
    __weak IBOutlet UILabel *rateLab;
    
    
    __weak IBOutlet NSLayoutConstraint *infobgToLeft;
    
    __weak IBOutlet NSLayoutConstraint *rateLabToTop;
    
    __weak IBOutlet NSLayoutConstraint *rateLabToLeft;
    
    __weak IBOutlet UIView *infoBg;
}
@property (nonatomic) int  type;// 0 显示应聘岗位的 1 不显示应聘岗位
@property (nonatomic) BOOL showRateView;//yes显示 no不显示

@property (nonatomic) NSString *urgentJobName;
/**
 加载数据
 */
-(void)loadData:(NSDictionary*)dictionary;
@end
