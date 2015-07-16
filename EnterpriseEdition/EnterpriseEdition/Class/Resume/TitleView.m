//
//  TitleView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *containerView = [[[UINib nibWithNibName:@"TitleView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        cornerView.layer.cornerRadius = cornerView.frame.size.height/2;
        cornerView.layer.masksToBounds = YES;
    }
    return self;
}

@end
