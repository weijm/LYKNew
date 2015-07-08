//
//  HomePageTableViewCell.m
//  无用
//
//  Created by lyk on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadEveryCell
{
    NSInteger index = self.tag;
    switch (index) {
        case 0:
            titleLab.text = @"待处理简历";
            break;
            
        case 1:
            titleLab.text = @"简历搜索 ";
            break;
        case 2:
            titleLab.text = @"简历智能推荐";
            break;
        case 3:
            contentBg.hidden = YES;
            addBg.hidden = NO;
            break;
        
        default:
            break;
    }
}
@end
