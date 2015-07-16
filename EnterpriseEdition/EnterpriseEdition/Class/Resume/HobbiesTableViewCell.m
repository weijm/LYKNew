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
-(void)loadContent:(NSString*)content type:(int)type
{
    switch (type) {
        case 3:
            titleView.titleLab.text = @"特长/兴趣";
            break;
        case 5:
            titleView.titleLab.text = @"自我评价";
            contentLab.text = @"对待工作认真负责，善于沟通、协调有较强的组织能力与团队精神;活泼开朗、乐观上进、有爱心并善于施教并行;上进心强、勤于学习能不断提高自身的能力与综合素质。";
            break;
        case 6:
            titleView.titleLab.text = @"个人荣誉";
            contentLab.text = @"劳模, 五一劳动奖章 , XX比赛XX奖";
            break;
            
        default:
            break;
    }
}
@end
