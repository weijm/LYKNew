//
//  JobIntensionTableViewCell.m
//  求职意向Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "JobIntensionTableViewCell.h"
#import "TitleView.h"

@implementation JobIntensionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    titleView.titleLab.text = @"求职意向";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//加载数据
-(void)loadData:(NSObject*)object
{
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *dataArray = (NSArray*)object;
        if ([dataArray count]>0) {
            infoBg.hidden = NO;
            emptyView.hidden = YES;
            NSDictionary *dictionary = [dataArray firstObject];
            industryLab.text = [Util getCorrectString:[dictionary objectForKey:@"industry_name"]];
            jobLab.text = [Util getCorrectString:[dictionary objectForKey:@"job_type_name"]];
            jobTypeLab.text = [CombiningData getJobType:[[dictionary objectForKey:@"employment_type"] intValue]];
            cityLab.text = [NSString stringWithFormat:@"%@%@%@",[Util getCorrectString:[dictionary objectForKey:@"city_name"]],[Util getCorrectString:[dictionary objectForKey:@"city_name_1"]],[Util getCorrectString:[dictionary objectForKey:@"city_name_2"]]];
            salaryLab.text = [NSString stringWithFormat:@"%dK-%dK",[[dictionary objectForKey:@"salary_min"] intValue]/1000,[[dictionary objectForKey:@"salary_max"] intValue]/1000];
            
        }else
        {
            infoBg.hidden = YES;
            emptyView.hidden = NO;
            
        }
    }else
    {
        infoBg.hidden = YES;
        emptyView.hidden = NO;
   
    }
}
@end
