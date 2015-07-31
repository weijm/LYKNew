//
//  ClaimPositionPromptView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/28.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ClaimPositionPromptView.h"

@implementation ClaimPositionPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"ClaimPositionPromptView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
      
        [self setLabParagraphStyle];
        if (kIphone6||kIphone6plus) {
            proLab.font = [UIFont systemFontOfSize:17];
        }
    }
    return self;
}

-(void)setLabParagraphStyle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;// 字体的行间距
    
    float fontSize = 13;
    if (kIphone6plus) {
        fontSize = 15;
    }
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:
                                     Rgb(115, 115, 115, 1.0)
                                 };
    firstLab.attributedText = [[NSAttributedString alloc] initWithString:firstLab.text attributes:attributes];
}

@end
