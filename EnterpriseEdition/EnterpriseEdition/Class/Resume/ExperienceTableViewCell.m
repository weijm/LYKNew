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
-(void)loadExperience:(NSObject*)obj
{
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray*)obj;
        if ([array count]>0) {
            infobg.hidden = NO;
            emptyView.hidden = YES;
            for (UIView *vie in [infobg subviews]) {
                if (vie) {
                    [vie removeFromSuperview];
                }
            }

            for (int i = 0; i < [array count]; i++)
            {
                NSDictionary *dic = [array objectAtIndex:i];
                NSString *content = [dic objectForKey:@"job_description"];
                int row = [Util getRow:(int)[content length] eachCount:[self getEachLength]];
                float height = 80+row*18;
                CGRect frame = CGRectMake(0, height*i, kWidth-85, height);
                ExperienceView *view = [[ExperienceView alloc] initWithFrame:frame];
                [view loadData:dic];
                [infobg addSubview:view];
            }
            
        }else
        {
            infobg.hidden = YES;
            emptyView.hidden = NO;
        }
    }else
    {
        infobg.hidden = YES;
        emptyView.hidden = NO;
    }
}
-(int)getEachLength
{
    if (kIphone4||kIphone5) {
        return 18;
    }else
    {
        return 22;
    }
}
@end
