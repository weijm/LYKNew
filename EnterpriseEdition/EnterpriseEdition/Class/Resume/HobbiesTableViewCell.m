//
//  HobbiesTableViewCell.m
//  特长/兴趣 自我评价 个人荣誉Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HobbiesTableViewCell.h"
#import "TitleView.h"
@implementation HobbiesTableViewCell

- (void)awakeFromNib {
    // Initialization code
    titleView.titleLab.text = @"特长/兴趣";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadContent:(NSObject*)contentObj type:(int)type
{
    switch (type) {
        case 3:
        {
            titleView.titleLab.text = @"特长/兴趣";
            [self getContent:contentObj key:@"interest"];

        }
            break;
        case 5:
            titleView.titleLab.text = @"自我评价";
            [self getContent:contentObj key:@"self_appraisal"];
//            contentLab.text = @"对待工作认真负责，善于沟通、协调有较强的组织能力与团队精神;活泼开朗、乐观上进、有爱心并善于施教并行;上进心强、勤于学习能不断提高自身的能力与综合素质。";
            break;
        case 6:
            titleView.titleLab.text = @"个人荣誉";
//            contentLab.text = @"劳模, 五一劳动奖章 , XX比赛XX奖";
            [self getContent:contentObj key:@"reward"];
            break;
            
        default:
            break;
    }
}
-(void)getContent:(NSObject*)object key:(NSString*)key
{
    UILabel *tempLab = (UILabel*)[self.contentView viewWithTag:100];
    if (tempLab) {
        [tempLab removeFromSuperview];
    }
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *dataArray = (NSArray*)object;
        if ([dataArray count]>0) {
            NSDictionary* dic = [dataArray firstObject];
            NSString *content = [Util getCorrectString:[dic objectForKey:key]];
            content = [content stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
            float labX = titleView.frame.origin.x + titleView.frame.size.width+[Util myXOrWidth:5];
            float labY = [Util myYOrHeight:20];
            float labW = kWidth - labX-[Util myXOrWidth:5];
            
            if ([content length]>0) {
                
                CGSize textSize = [content sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(labW, MAXFLOAT)];
                
                UILabel *conLab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, textSize.height)];
                conLab.text = content;
                conLab.font = [UIFont systemFontOfSize:14];
                conLab.backgroundColor = [UIColor clearColor];
                conLab.tag = 100;
                conLab.numberOfLines = 0;
                conLab.alpha = 0.7;
                [self.contentView addSubview:conLab];
                
                
                
                
                emptyView.hidden = YES;
            }else
            {
                emptyView.hidden = NO;
            }
        }else
        {
            emptyView.hidden = NO;
        }
    }else
    {
        emptyView.hidden = NO;
    }
}
-(float)getLabWidth
{
    if (kIphone6plus) {
        return 300;
    }else if (kIphone6)
    {
        return 222;
    }else
    {
        return 222;
    }
}
@end
