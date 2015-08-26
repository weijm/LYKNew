//
//  HeaderView.m
//  简历首页最顶部视图
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HeaderView.h"
#import "ResumeChooseBtView.h"
#import "UIButton+Custom.h"

#define kEdgeWidth 25
#define kBTHeight 28

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"HeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        CGRect frame1 = CGRectMake([Util myXOrWidth:kEdgeWidth], [Util myYOrHeight:10], (kWidth-[Util myXOrWidth:kEdgeWidth]*2), [Util myYOrHeight:kBTHeight]);
        subbg = [[UIView alloc] initWithFrame:frame1];
        subbg.layer.cornerRadius = 5;

        subbg.layer.borderColor = [UIColor colorWithRed:0.0078 green:0.5451 blue:0.902 alpha:1.0].CGColor;
        subbg.layer.borderWidth = 1.5;
        subbg.layer.masksToBounds= YES;
        [chooseBg addSubview:subbg];
        //初始化按钮
        [self initButtonView];
        if (kIphone5||kIphone4) {
            filtrateBt.titleLabel.font = [UIFont systemFontOfSize:11];
        }
    }
    return self;
}
- (void)initButtonView
{
    for (int i =0; i <3; i++) {
        float btW = subbg.frame.size.width/3;
        CGRect frame = CGRectMake(btW*i, 0, btW, subbg.frame.size.height);
        ResumeChooseBtView *bt = [[ResumeChooseBtView alloc] initWithFrame:frame];
        bt.tag = i;
        bt.clickedBtAction = ^(NSInteger index){
            [self chooseBtAction:index];
        };
        [bt loadSubView];
        [subbg addSubview:bt];
    }
}
-(void)chooseBtAction:(NSInteger)index
{
    //界面更改
    [self changeButtonBgAndTextColor:(int)index];
    //事件处理
    self.chooseHeaderBtAction(index);
}
-(void)changeButtonBgAndTextColor:(int)index
{
    for (ResumeChooseBtView *view in [subbg subviews]) {
        if ([view isKindOfClass:[ResumeChooseBtView class]]) {
            if (view.tag != index) {
                [view.chooseBt setTitleColor:Rgb(49, 129, 218, 1.0) forState:UIControlStateNormal];
                view.chooseBt.backgroundColor = [UIColor clearColor];
            }else
            {
                view.chooseBt.backgroundColor = Rgb(2, 139, 230, 1.0);
                [view.chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    
}
//点击删选按钮 触发的事件
- (IBAction)clickedFiltreateBtAction:(id)sender {
    self.clickedFiltrateAction();
}
@end
