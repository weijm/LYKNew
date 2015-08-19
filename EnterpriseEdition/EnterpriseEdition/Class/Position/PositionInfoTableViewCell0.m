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
        positionImgHeight.constant = positionImgHeight.constant+3;
        positionImgWidth.constant = positionImgWidth.constant +3;

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadData:(NSDictionary*)dictionary
{
    if (dictionary) {
        titleLab.text = [dictionary objectForKey:@"title"];
        contentLab.text = [NSString stringWithFormat:@"%@ | %@",[Util getCorrectString:[dictionary objectForKey:@"job_type_name"]],[dictionary objectForKey:@"industry_name"]];
        NSString *status = [dictionary objectForKey:@"status"];
        if ([status isEqualToString:@"正常"]) {
            status = @"有效";
            statusImg.image = [UIImage imageNamed:@"position_valid_mark"];
            promptLab.textColor = Rgb(2, 139, 230, 1.0);
        }else
        {
            statusImg.image = [UIImage imageNamed:@"position_invalid_mark"];
            promptLab.textColor = Rgb(163, 163, 163, 1.0);
        }
        promptLab.text = status;
    }
    
    //判断是否是急招职位
    if (_isUrgentPosition) {
        urgentImg.hidden = NO;
    }else
    {
        urgentImg.hidden = YES;
    }
    
}
@end
