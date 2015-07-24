//
//  InfoDetailTitleAndImgTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoDetailTitleAndImgTableViewCell.h"

@implementation InfoDetailTitleAndImgTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//加载数据 及视图
-(void)loadsubView:(NSDictionary*)dictionary
{
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = bg.bounds;
//    maskLayer.path = maskPath.CGPath;
//    bg.layer.mask = maskLayer;
}
@end
