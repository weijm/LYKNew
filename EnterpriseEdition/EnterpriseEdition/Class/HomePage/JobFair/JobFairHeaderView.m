//
//  JobFairHeaderView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/9/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "JobFairHeaderView.h"
#import "ResumeChooseBtView.h"
#import "UIButton+Custom.h"
#define kEdgeWidth 23
#define kBTHeight 28
@implementation JobFairHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect frame1 = CGRectMake([Util myXOrWidth:kEdgeWidth], [Util myYOrHeight:10], (kWidth-[Util myXOrWidth:kEdgeWidth]*2), [Util myYOrHeight:kBTHeight]);
        subbg = [[UIView alloc] initWithFrame:frame1];
        subbg.layer.cornerRadius = 5;
        
        subbg.layer.borderColor = [UIColor colorWithRed:0.0078 green:0.5451 blue:0.902 alpha:1.0].CGColor;;
        subbg.layer.borderWidth = 2.0;
        subbg.layer.masksToBounds= YES;
        [self addSubview:subbg];
        //初始化按钮
        [self initButtonView];
        
        [self initPhoneView:CGRectMake(frame1.origin.x, frame1.origin.y+frame1.size.height, frame1.size.width, [Util myYOrHeight:30])];
        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}
//招聘会咨询热线
-(void)initPhoneView:(CGRect)frame1
{
    NSString *contentStr = @"提示：招聘会咨询服务热线 4008-907-977";
    float fontSize = 12;
    if (kIphone6) {
        fontSize = 13;
    }else if(kIphone6plus)
    {
         fontSize = 14;
    }
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:frame1];
    phoneLab.text = contentStr;
    phoneLab.font = [UIFont systemFontOfSize:fontSize];
    phoneLab.textColor = Rgb(142, 145, 146, 1.0);
    phoneLab.textAlignment = NSTextAlignmentCenter;
    phoneLab.userInteractionEnabled = YES;
    NSRange range = [contentStr rangeOfString:@"4008-907-977"];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    //设置字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:Rgb(91, 147, 202, 1.0)
     
                          range:range];
    
    phoneLab.attributedText = attributedStr;
    
    [self addSubview:phoneLab];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeCall)];
    [phoneLab addGestureRecognizer:tap];
    
    
}
//初始化按钮
- (void)initButtonView
{
    for (int i =0; i <2; i++) {
        float btW = subbg.frame.size.width/2;
        CGRect frame = CGRectMake(btW*i, 0, btW, subbg.frame.size.height);
        ResumeChooseBtView *bt = [[ResumeChooseBtView alloc] initWithFrame:frame];
        bt.tag = i;
        bt.clickedBtAction = ^(NSInteger index){
            [self chooseBtAction:index];
        };
        [bt loadSubViewInJobFair];
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

-(void)makeCall
{
    self.makeCallAction(@"4008907977");
    
}
@end
