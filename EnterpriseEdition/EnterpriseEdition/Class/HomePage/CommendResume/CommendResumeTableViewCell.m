//
//  CommendResumeTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CommendResumeTableViewCell.h"

@implementation CommendResumeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadSubViewData:(NSDictionary*)dictionary
{
    int urgent = [[dictionary objectForKey:@"urgent"] intValue];
    if (urgent == 0) {//急招职位
        urgentImg.hidden = NO;
    }else {//非急招职位
        urgentImg.hidden = YES;
    }
    
    positionTitle.text = [dictionary objectForKey:@"job"];
    positionInfo.text = [NSString stringWithFormat:@"%@ | %@",[dictionary objectForKey:@"name"],[dictionary objectForKey:@"pro"]];
}
@end
