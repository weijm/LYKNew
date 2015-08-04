//
//  ReferenceView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ReferenceView.h"

@implementation ReferenceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"ReferenceView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        expBt.layer.cornerRadius = 3;
        expBt.layer.borderWidth = 1.5;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.553, 0.7490, 0.9412, 1 });
        expBt.layer.borderColor = colorref;
        expBt.layer.masksToBounds = YES;
    }
    return self;
}


- (IBAction)lookUpExample:(id)sender {
    self.lookExampleAction();
}
@end