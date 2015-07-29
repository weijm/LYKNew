//
//  PositionInfoTableViewCell0.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionInfoTableViewCell0.h"

@implementation PositionInfoTableViewCell0

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        positionImgHeight.constant = positionImgHeight.constant*1.5;
        positionImgWidth.constant = positionImgWidth.constant *1.5;

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
