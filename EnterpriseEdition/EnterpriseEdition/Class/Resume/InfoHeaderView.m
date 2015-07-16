//
//  InfoHeaderView.m
//  简介详情的headerView
//
//  Created by wjm on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoHeaderView.h"

@implementation InfoHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"InfoHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        protraitImag.layer.cornerRadius = protraitImag.frame.size.height/2;
        protraitImag.layer.masksToBounds = YES;
        rateLab.layer.cornerRadius = rateLab.frame.size.height/2;
        rateLab.layer.masksToBounds = YES;
        
        expLab.layer.cornerRadius = expLab.frame.size.height/2;
        expLab.layer.masksToBounds = YES;
        expLab.layer.borderWidth = 1;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.918, 0.667, 0.494, 1 });
        expLab.layer.borderColor = colorref;
        
    }
    return self;
}


@end
