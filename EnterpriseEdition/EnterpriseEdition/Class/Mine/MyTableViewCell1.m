//
//  MyTableViewCell1.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "MyTableViewCell1.h"
#import "TopImgBotTitleView.h"

@implementation MyTableViewCell1

- (void)awakeFromNib {
    // Initialization code
//    [self loadsubView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadsubView:(NSDictionary*)dictionary
{
    float viewW = (kWidth)/3;
    for (UIView *vie in [bg subviews]) {
        if ([vie isKindOfClass:[TopImgBotTitleView class]]) {
            [vie removeFromSuperview];
        }
    }
    for (int i =0; i < 3; i++) {
       
        CGRect frame = CGRectMake(viewW*i, 0, viewW, [Util myYOrHeight:87]);
        TopImgBotTitleView *subView= [[TopImgBotTitleView alloc] initWithFrame:frame];
        subView.tag = i;
        [subView loadData:i Content:dictionary];
        [bg addSubview:subView];
    }
}
@end
