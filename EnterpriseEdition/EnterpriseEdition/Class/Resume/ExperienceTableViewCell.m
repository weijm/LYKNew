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
            float oldViewY = 0;
            float sizeX = [Util myXOrWidth:160];

            if (kIphone4||kIphone5) {
                sizeX = 250;
            }
            for (int i = 0; i < [array count]; i++)
            {
                NSDictionary *dic = [array objectAtIndex:i];
                NSString *content = [[dic objectForKey:@"job_description"] stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
                CGSize titleSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake([self getLabWidth], MAXFLOAT)];
                int row = [Util getRow:(int)[content length] eachCount:[self getEachLength]];
//                float height = 90+row*18;
                float height = titleSize.height+90;
                if (row ==1) {
                    height = [Util myYOrHeight:80]+row*19;
                }
                CGRect frame = CGRectMake(0, oldViewY, kWidth-85, height);
                ExperienceView *view = [[ExperienceView alloc] initWithFrame:frame];
                [view loadData:dic];
                [infobg addSubview:view];
                oldViewY = oldViewY+height;
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
-(float)getLabWidth
{
    if (kIphone6plus) {
        return 260;
    }else
    {
        return 222;
    }
    
}
-(float)getLabFontSize
{
    if (kIphone5||kIphone4) {
        return 13;
    }else
    {
        return 12;
    }
}
@end
