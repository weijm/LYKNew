//
//  InfoDetailTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoDetailTableViewCell.h"

@implementation InfoDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setTextViewParagraphStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//加载数据 及视图
-(void)loadsubView:(NSDictionary*)dictionary
{
    if (_infoType == 1) {//普通消息 设置连个圆角
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bg.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = bg.bounds;
//        maskLayer.path = maskPath.CGPath;
//        bg.layer.mask = maskLayer;
    }else
    {
        bg.layer.cornerRadius = 5.0;
        bg.layer.masksToBounds = YES;
    }
}
-(void)setTextViewParagraphStyle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:
                                     Rgb(115, 115, 115, 1.0)
                                 };
    contentTextView.attributedText = [[NSAttributedString alloc] initWithString:contentTextView.text attributes:attributes];
}
@end
