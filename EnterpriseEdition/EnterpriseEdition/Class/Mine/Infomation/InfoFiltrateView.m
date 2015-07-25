//
//  InfoFiltrateView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoFiltrateView.h"

@implementation InfoFiltrateView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"InfoFiltrateView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
-(void)showInView:(UIView *)view
{
    UIView *areaBg = [[UIView alloc] initWithFrame:view.frame];
    areaBg.backgroundColor = [UIColor clearColor];
    areaBg.tag = 250;
    [view addSubview:areaBg];
    
    UIView *alphBg = [[UIView alloc] initWithFrame:view.frame];
    alphBg.backgroundColor = [UIColor blackColor];
    alphBg.alpha = 0;
    [areaBg addSubview:alphBg];
    
    float viewX = kWidth - 130-[Util myXOrWidth:12];
    
    self.frame = CGRectMake(viewX, 64, 130, 101);
    [view addSubview:self];
    
    self.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        alphBg.alpha = 0.2;
        self.alpha = 1.0;
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)];
    [areaBg addGestureRecognizer:tap];
}
-(void)cancelView
{
    UIView *supView = [self superview];
    UIView *areaBg = [supView viewWithTag:250];
    [UIView animateWithDuration:0.3 animations:^{
        areaBg.alpha = 0;
        self.alpha = 0.0;
    } completion:^(BOOL finished){
        [areaBg removeFromSuperview];
        [self removeFromSuperview];
    }];
    
    self.touchAction(0);
}


- (IBAction)chooseAction:(id)sender {
    UIButton *bt = (UIButton*)sender;
    self.touchAction((int)bt.tag);
    [self cancelView];
}
@end
