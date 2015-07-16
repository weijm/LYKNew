//
//  ExperienceTableViewCell.m
//  实习经验cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ExperienceTableViewCell.h"
#import "TitleView.h"
#import "ExperienceView.h"
@implementation ExperienceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    titleView.titleLab.text = @"实习经验";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadExperience:(NSArray*)array
{
    for (int i = 0; i < [array count]; i++)
    {
        float height = 150;
        CGRect frame = CGRectMake(0, height*i, kWidth-85, height);
        ExperienceView *view = [[ExperienceView alloc] initWithFrame:frame];
        [infobg addSubview:view];
    }
}
@end
