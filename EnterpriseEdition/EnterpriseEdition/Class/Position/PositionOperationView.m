//
//  PositionOperationView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionOperationView.h"

@implementation PositionOperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"PositionOperationView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
      
    }
    return self;
}
-(void)showView:(UIView *)view
{
    UIView *areaBg = [[UIView alloc] initWithFrame:view.frame];
    areaBg.backgroundColor = [UIColor clearColor];
    areaBg.tag = 250;
    [view addSubview:areaBg];
    
    UIView *alphBg = [[UIView alloc] initWithFrame:view.frame];
    alphBg.backgroundColor = [UIColor blackColor];
    alphBg.alpha = 0;
    [areaBg addSubview:alphBg];
    
    float height = 135;
    self.frame = CGRectMake(0, view.frame.size.height, kWidth, height);
    [view addSubview:self];

    [UIView animateWithDuration:0.3 animations:^{
        
        alphBg.alpha = 0.2;
        CGRect frame = self.frame;
        frame.origin.y = view.frame.size.height-self.frame.size.height;
        self.frame = frame;
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)];
    [areaBg addGestureRecognizer:tap];
}
-(void)cancelView
{
    UIView *supView = [self superview];
    UIView *areaBg = [supView viewWithTag:250];
    float height = [Util myYOrHeight:216];
    [UIView animateWithDuration:0.3 animations:^{
        areaBg.alpha = 0;
        CGRect frame = self.frame;
        frame.origin.y = frame.origin.y+height;
        self.frame = frame;
    } completion:^(BOOL finished){
        [areaBg removeFromSuperview];
        [self removeFromSuperview];
    }];
}
- (IBAction)operationPositionAction:(id)sender
{
    UIButton *bt = (UIButton*)sender;
    int index = (int)bt.tag;
    self.operationPosition(index);
    [self cancelView];
    
}
@end
