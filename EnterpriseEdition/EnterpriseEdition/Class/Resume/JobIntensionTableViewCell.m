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

@end
