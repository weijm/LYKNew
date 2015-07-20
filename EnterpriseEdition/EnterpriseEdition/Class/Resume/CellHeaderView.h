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
    IBOutlet UILabel *jobTitLab;
    //应聘岗位
    IBOutlet UILabel *jobLab;
    //急招标志
    
    IBOutlet UIView *btbg;
    
    //时间
    IBOutlet UILabel *timeLab;
}
@property (nonatomic) int  type;// 0 显示应聘岗位的 1 不显示应聘岗位
/**
 加载数据
 */
-(void)loadData:(NSDictionary*)dictionary;
@end
