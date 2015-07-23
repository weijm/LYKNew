//
//  PositionInfoTableViewCell1.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionInfoTableViewCell1.h"
#import "ItemView.h"

@implementation PositionInfoTableViewCell1

- (void)awakeFromNib {
    // Initialization code
    [self loadsubView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadsubView
{
    float itemW = (kWidth-40)/3;
    for (int i = 0; i < 3; i++) {
        CGRect frame = CGRectMake(itemW*i, 0, itemW, 30);
        ItemView *item = [[ItemView alloc] initWithFrame:frame];
        item.iconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"position_item_icon%d",i]];
        item.tag = i;
        [item loadData];
        [topbg addSubview:item];
    }
    for (int i = 3; i < 5; i++) {
        CGRect frame = CGRectMake(itemW*(i-3), 0, itemW, 30);
        ItemView *item = [[ItemView alloc] initWithFrame:frame];
        item.iconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"position_item_icon%d",i]];
        item.tag = i;
        [item loadData];
        [midBg addSubview:item];
        
    }
    
    CGRect frame = CGRectMake(0, 0, kWidth-40, 40);
    ItemView *item = [[ItemView alloc] initWithFrame:frame];
    item.tag = 5;
    [item loadData];
    item.iconImg.image = [UIImage imageNamed:@"position_item_icon5"];
    [botBg addSubview:item];
}
@end
