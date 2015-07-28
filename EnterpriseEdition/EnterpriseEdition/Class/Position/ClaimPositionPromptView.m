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
       
        if (kIphone6||kIphone6plus) {
            proLab.font =[UIFont systemFontOfSize:17];
        }
    }
    return self;
}


@end
