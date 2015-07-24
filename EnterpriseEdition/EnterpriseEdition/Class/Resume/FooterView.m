//
//  FooterView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/11.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "FooterView.h"
#import "ResumeChooseBtView.h"
#import "UIButton+Custom.h"



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
    }
    return self;
}
-(void)loadEditButton:(int)index
{
    if (_position==1) {//职位页面的编辑footer
        switch (index) {
            case 1:
                [self initButtonView:4 index:index];
                break;
            case 2:
                [self initButtonView:3 index:index];
                break;
            case 3:
                [self initButtonView:2 index:index];
                break;
            default:
                break;
        }
    }else if (_position ==2)
    {//职位详情页面的编辑footer
        [self initButtonView:3 index:1];
    }else if (_position == 3)
    {
        //信息页面的编辑footer
        [self initButtonView:2 index:2];
    }
    else
    {
        switch (index) {
            case 1:
                [self initButtonView:3 index:index];
                break;
            case 2:
                [self initButtonView:2 index:index];
                break;
            case 3:
                [self initButtonView:3 index:index];
                break;
            default:
                break;
        }

    }
}

- (void)initButtonView:(int)btCount index:(int)index
{
    int var = 10;
    if (index == 1) {
        var = 10;
    }else if (index == 2)
    {
        var = 100;
    }else
    {
        var = 1000;
    }
    for (int i =0; i <btCount; i++) {
        float btW = kWidth/btCount;
        CGRect frame = CGRectMake(btW*i, 0, btW, kFOOTERVIEWH);
        ResumeChooseBtView *bt = [[ResumeChooseBtView alloc] initWithFrame:frame];
        bt.tag = (i+1)*var;
        bt.clickedBtAction = ^(NSInteger index){
            [self chooseBtAction:index];
        };
        if (_position ==1) {//职位页面的编辑footer
            [bt loadPositionFooterSubView];
        }else if (_position == 2)
        {//职位详情页面的编辑footer
            [bt loadPositionInfoFooterSubView];
        }else if (_position ==3)
        {
            [bt loadInfoInfoFooterSubView];
        }
        else
        {
            [bt loadFooterSubView];
        }
        
        [subView addSubview:bt];
    }
}
-(void)chooseBtAction:(NSInteger)index
{
    NSLog(@"footer index == %ld",index);
    if (index == 10||index ==100||index == 1000) {//判断 是全选 还是取消全选
        ResumeChooseBtView *btView = (ResumeChooseBtView *)[subView viewWithTag:index];
        if (btView.chooseBt.specialMark == 0) {
            btView.chooseBt.specialMark =1;
            self.chooseFooterBtAction(index,YES);
        }else
        {
            btView.chooseBt.specialMark = 0;
            self.chooseFooterBtAction(index,NO);
        }
    }else
    {
        self.chooseFooterBtAction(index,NO);
    }
    
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
//取消全选按钮 被选中的状态
-(void)revertChooseBtByIndex:(int)index
{
    ResumeChooseBtView *tempView = (ResumeChooseBtView*)[subView viewWithTag:index];
    tempView.chooseBt.specialMark = 0;
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
