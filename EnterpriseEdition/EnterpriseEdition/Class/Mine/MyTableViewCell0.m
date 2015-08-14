//
//  MyTableViewCell0.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "MyTableViewCell0.h"
#import "UIImageView+WebCache.h"

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
    iconImg.layer.cornerRadius = iconHeight.constant/2;
    iconImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadSubView:(NSDictionary*)dictionary
{
    NSString *logoUrl = [dictionary objectForKey:@"logo_url"];
    if ([[Util getCorrectString:logoUrl] length]>0) {
        [iconImg sd_setImageWithURL:[NSURL URLWithString:logoUrl] placeholderImage:[UIImage imageNamed:@"my_icon"]];
    }

    NSString *name = [Util getCorrectString:[dictionary objectForKey:@"company_name"]];
    if ([name length]>0) {
        enterpriseNameLab.text = name;
    }else
    {
        enterpriseNameLab.text = @"暂无";
    }
    
    int  status = [[dictionary objectForKey:@"ent_status"] intValue];
    if (status == 1) {
        statusImg.image = [UIImage imageNamed:@"my_check_pass"];
    }else
    {
        statusImg.image = [UIImage imageNamed:@"my_check_nopass"];
    }
    if (dictionary !=nil) {
        NSString *str1 = [Util getCorrectString:[dictionary objectForKey:@"city_id_1"]];
        NSString *str2 = [Util getCorrectString:[dictionary objectForKey:@"city_id_2"]];
        if ([str1 isEqualToString:str2]) {
            locationLab.text = [NSString stringWithFormat:@"%@|%@",str2,[Util getCorrectString:[dictionary objectForKey:@"city_id_3"]]];
        }else
        {
            locationLab.text = [NSString stringWithFormat:@"%@|%@|%@",str1,str2,[Util getCorrectString:[dictionary objectForKey:@"city_id_3"]]];
        }
        
    }
    
}
@end
