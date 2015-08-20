//
//  ItemView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"ItemView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        if (kIphone6plus) {
            iconWidth.constant = iconWidth.constant +2;
            iconHeight.constant = iconHeight.constant +2;
        }
       
    }
    return self;
}
-(void)loadData:(NSDictionary*)dic
{
    switch (self.tag) {
        case 0:
        {
            NSString *salary_min = [dic objectForKey:@"salary_min"];
            NSString *salary_max = [dic objectForKey:@"salary_max"];
              _contentLab.text = [NSString stringWithFormat:@"%dK-%dK",[salary_min intValue]/1000,[salary_max intValue]/1000];
        }
            break;
        case 1:
        {
            _contentLab.text = [NSString stringWithFormat:@"%@人",[dic objectForKey:@"need_count"]];
        }
            break;
        case 2:
        {
             _contentLab.text = [dic objectForKey:@"work_type"];
        }
           
            break;
        case 3:
            _contentLab.text = [dic objectForKey:@"work_exp_type"];
            break;
        case 4:
            _contentLab.text = [dic objectForKey:@"certificate_type"];
            break;
        case 5:
        {
            labHeight.constant = 40;
            _contentLab.numberOfLines = 2;
            
            NSString *str1 = [Util getCorrectString:[dic objectForKey:@"city_name_1"]];
            NSString *str2 = [Util getCorrectString:[dic objectForKey:@"city_name_2"]];
            NSString *str3 = [Util getCorrectString:[dic objectForKey:@"city_name_3"]];
            if ([str1 isEqualToString:str2]) {
                _contentLab.text = [NSString stringWithFormat:@"%@%@%@",str1,str3,[Util getCorrectString:[dic objectForKey:@"address"]]];
            }else
            {
                _contentLab.text = [NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,[Util getCorrectString:[dic objectForKey:@"address"]]];
            }
            
            //当地址为两行时 图标向上移动
            int line = [Util getRow:(int)[_contentLab.text length] eachCount:20];
            if (line >= 2) {
                iconY.constant = (kIphone6plus)?4:7;
            }
        }
            break;
                default:
            break;
    }
}

@end
