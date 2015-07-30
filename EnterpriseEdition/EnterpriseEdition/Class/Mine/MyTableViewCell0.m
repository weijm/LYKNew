//
//  MyTableViewCell0.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "MyTableViewCell0.h"

@implementation MyTableViewCell0

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        iconWidth.constant = iconWidth.constant+5;
        iconHeight.constant = iconHeight.constant +5;
        
        reviewHeight.constant = reviewHeight.constant+1;
        reviewWidth.constant = reviewWidth.constant+3;
        
        arrowwidth.constant = arrowwidth.constant+1;
        arrowHeight.constant = arrowHeight.constant+1;
        
        enterpriseNameLab.font = [UIFont systemFontOfSize:17];
        locationLab.font = [UIFont systemFontOfSize:14];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
