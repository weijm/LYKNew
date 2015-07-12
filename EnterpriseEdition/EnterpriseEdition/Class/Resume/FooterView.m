//
//  FooterView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/11.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "FooterView.h"
#import "ResumeChooseBtView.h"



@implementation FooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"FooterView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        //初始化按钮
        [self initButtonView];
    }
    return self;
}


- (void)initButtonView
{
    for (int i =0; i <3; i++) {
        float btW = kWidth/3;
        CGRect frame = CGRectMake(btW*i, 0, btW, kFOOTERVIEWH);
        ResumeChooseBtView *bt = [[ResumeChooseBtView alloc] initWithFrame:frame];
        bt.tag = (i+1)*10;
        bt.clickedBtAction = ^(NSInteger index){
            [self chooseBtAction:index];
        };
        [bt loadFooterSubView];
        [subView addSubview:bt];
    }
}
-(void)chooseBtAction:(NSInteger)index
{
    NSLog(@"footer index == %ld",index);
    self.chooseFooterBtAction(index);
}
//设置按钮可点击或不可点击
-(void)setButton:(NSArray*)array Enable:(BOOL)isEnable
{
    for (int i =0; i < [array count]; i++) {
        NSInteger index = [[array objectAtIndex:i] integerValue];
        ResumeChooseBtView *tempView = (ResumeChooseBtView*)[subView viewWithTag:index];
        if (tempView) {
            tempView.userInteractionEnabled = isEnable;
        }
    }
}
//显示footerView
-(void)showFooterView:(UIView*)supview
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = kHeight - kFOOTERVIEWH;
        self.frame = frame;
    }];
}
//取消footerView
-(void)cancelFooterView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = kHeight ;
        self.frame = frame;
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}
@end
