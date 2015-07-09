//
//  CellMiddleView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CellMiddleView.h"

@implementation CellMiddleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"CellMiddleView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        protraitImg.layer.cornerRadius = protraitImg.frame.size.width;
        experienceLab.layer.cornerRadius = experienceLab.frame.size.height/2;
        experienceLab.layer.masksToBounds = YES;
    }
    return self;
}


@end
