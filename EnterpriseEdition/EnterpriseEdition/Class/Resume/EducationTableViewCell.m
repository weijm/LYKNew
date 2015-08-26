//
//  EducationTableViewCell.m
//  教育背景Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EducationTableViewCell.h"
#import "TitleView.h"
#import "EducationView.h"

@implementation EducationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    titleView.titleLab.text = @"教育背景";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadData:(NSObject*)object
{
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *dataArray = (NSArray*)object;
        NSInteger count = [dataArray count];
        if (count == 0) {
            infoBg.hidden = YES;
            emptyView.hidden = NO;
        }else
        {
            infoBg.hidden = NO;
            emptyView.hidden = YES;
        }
        float viewW = kWidth- 95;
        float viewH = 70;
        float edge = 5;
        for (UIView *vie in [infoBg subviews]) {
            if (vie) {
                [vie removeFromSuperview];
            }
        }
        for (int i =0; i< count; i++)
        {
            NSDictionary *dic = [dataArray objectAtIndex:i];
            EducationView *eduView = [[EducationView alloc] initWithFrame:CGRectMake(0, viewH*i+edge*i, viewW, viewH)];
            [eduView loadSubView:dic];
            [infoBg addSubview:eduView];
            
        }
        
    }else
    {
        infoBg.hidden = YES;
        emptyView.hidden = NO;
    }
}
@end
