//
//  CellHeaderView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CellHeaderView.h"
#import "UIButton+Custom.h"

@implementation CellHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"CellHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
//加载数据
-(void)loadData:(NSDictionary*)dictionary
{
    if(_type==0)
    {
        jobTitLab.hidden = NO;
        jobLab.hidden = NO;
    }else
    {
        jobTitLab.hidden = YES;
        jobLab.hidden = YES;
        
    }
    [self showRateViewBg];

    jobLab.text = [dictionary objectForKey:@"job"];
    timeLab.text = [dictionary objectForKey:@"time"];
    
}
-(void)showRateViewBg
{
    if (_showRateView) {
        rateView.hidden = NO;
        infobgToLeft.constant = 30;
        rateLab.transform = CGAffineTransformMakeRotation(-(180 / M_PI));
        
    }else
    {
        infobgToLeft.constant = 10;
        rateView.hidden = YES;
    }
}
-(void)clicked:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    NSLog(@"bt tag == %ld",(long)bt.tag);
}
-(void)setShowRateView:(BOOL)showRateView
{
    _showRateView = showRateView;
    
    if (showRateView) {
        rateView.hidden = NO;
    }else
    {
        rateView.hidden = YES;
    }
    

}
@end
