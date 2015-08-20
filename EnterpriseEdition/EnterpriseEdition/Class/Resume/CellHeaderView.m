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
        if (kIphone4||kIphone5) {
            jobTitLab.font = [UIFont systemFontOfSize:14];
            jobLab.font = [UIFont systemFontOfSize:14];
        }
    }
    return self;
}
//加载数据
-(void)loadData:(NSDictionary*)dictionary
{
//    if(_type==0)
//    {
//        jobTitLab.hidden = NO;
//        jobLab.hidden = NO;
//    }else
//    {
//        jobTitLab.hidden = YES;
//        jobLab.hidden = YES;
//        
//    }
    jobTitLab.hidden = NO;
    jobLab.hidden = NO;
    [self showRateViewBg];
    NSString *titleContent = [Util getCorrectString:[dictionary objectForKey:@"title"]];
    if (_type!=0) {
        titleContent = [Util getCorrectString:[dictionary objectForKey:@"job_type"]];
    }

    jobLab.text = titleContent;
    NSString *timeString = [dictionary objectForKey:@"add_time"];
    
    NSRange range = [timeString rangeOfString:@"2015-"];
    if (range.length>0) {
         timeString = [timeString substringFromIndex:(range.length+range.location)];
    }
    timeLab.text = timeString;
    
    NSString * rateStr = [Util getCorrectString:[dictionary objectForKey:@"result_value"]];
    if ([rateStr length]>0) {
        rateLab.text = [NSString stringWithFormat:@"%.0f%%",[rateStr floatValue]*100];
    }
    
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
//    UIButton *bt = (UIButton *)sender;
}
-(void)setShowRateView:(BOOL)showRateView
{
    _showRateView = showRateView;
    
    if (showRateView) {
        rateView.hidden = NO;
        jobTitLab.hidden = YES;
    }else
    {
        rateView.hidden = YES;
    }
    

}
@end
