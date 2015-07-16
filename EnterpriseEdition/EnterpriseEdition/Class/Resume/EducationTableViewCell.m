//
//  EducationTableViewCell.m
//  教育背景Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EducationTableViewCell.h"
#import "TitleView.h"

@implementation EducationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    titleView.titleLab.text = @"教育背景";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
