//
//  PositionInfoTableViewCell2.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionInfoTableViewCell2.h"

@implementation PositionInfoTableViewCell2

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        iconWidth.constant = iconWidth.constant +3;
        iconHeight.constant = iconHeight.constant +3;
    }
    [self setTextViewParagraphStyle];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTextViewParagraphStyle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:
                                     Rgb(115, 115, 115, 1.0)
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}
@end
