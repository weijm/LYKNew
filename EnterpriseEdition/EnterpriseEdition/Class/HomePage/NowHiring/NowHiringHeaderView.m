//
//  NowHiringHeaderView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/20.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "NowHiringHeaderView.h"
#import "ResumeChooseBtView.h"
#import "UIButton+Custom.h"
#define kEdgeWidth 25
#define kBTHeight 30
#define kPVHeight [Util myYOrHeight:50]
#define kLimitTime 72*60*60
@implementation NowHiringHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"NowHiringHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        CGRect frame1 = CGRectMake([Util myXOrWidth:kEdgeWidth], [Util myYOrHeight:11], (kWidth-[Util myXOrWidth:kEdgeWidth]*2), [Util myYOrHeight:kBTHeight]);
        subbg = [[UIView alloc] initWithFrame:frame1];
        subbg.layer.cornerRadius = 5;
   
        subbg.layer.borderColor = [UIColor colorWithRed:0.0078 green:0.5451 blue:0.902 alpha:1.0].CGColor;
        subbg.layer.borderWidth = 1.0;
        subbg.layer.masksToBounds= YES;
        [btBg addSubview:subbg];
        //初始化按钮
        [self initButtonView];
        
//        [self initProgressView];
        
        
    }
    return self;
}
//初始化剩余时间进度条
-(void)initProgressView
{
    NSArray *timeArr = [[_urgDic objectForKey:@"over_time"] componentsSeparatedByString:@":"];
    remainingTime = [[timeArr firstObject] intValue]*60*60+[timeArr[1] intValue]*60+[timeArr[2] intValue];

    float pvY = subbg.frame.origin.y-(kPVHeight - [Util myYOrHeight:kBTHeight])/2;
    circleProgressView = [[CircleProgressView alloc] initWithFrame:CGRectMake((kWidth-kPVHeight)/2,pvY , kPVHeight, kPVHeight)];
    [btBg addSubview:circleProgressView];
    
    self.session = [[Session alloc] init];
    self.session.startDate = [NSDate date];
    self.session.finishDate = nil;
    self.session.state = kSessionStateStart;
    
    circleProgressView.timeLimit = kLimitTime;
    
    UIColor *tintColor = [UIColor redColor];
    circleProgressView.status = NSLocalizedString(@"circle-progress-view.status-in-progress", nil);
    circleProgressView.tintColor = tintColor;
//    remainingTime = 16*60*60+45*60+30;
    circleProgressView.remainingTime = remainingTime;//剩余时间
    circleProgressView.elapsedTime = kLimitTime-remainingTime;//已过时间
    if (remainingTime!=0) {
        [self startTimer];
    }
    contentLab.text = [NSString stringWithFormat:@"%@/%@",[_urgDic objectForKey:@"resume_num"],[_urgDic objectForKey:@"resume_max"]];
    [self loadCountTextColor];
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
        [bt loadSubViewInNowHiring];
        [subbg addSubview:bt];
    }
}
-(void)loadCountTextColor
{
    NSRange range1 = [contentLab.text rangeOfString:@"/"];
    NSRange range = NSMakeRange(0, range1.location);
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:contentLab.text];
    //设置字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:range];
    contentLab.attributedText = attributedStr;
    contentLab.font = [UIFont systemFontOfSize:[Util myFontSize:12]];
}
-(void)chooseBtAction:(NSInteger)index
{
    //界面更改
    for (ResumeChooseBtView *view in [subbg subviews]) {
        if ([view isKindOfClass:[ResumeChooseBtView class]]) {
            if (view.tag != index) {
                [view.chooseBt setTitleColor:Rgb(49, 129, 218, 1.0) forState:UIControlStateNormal];
                view.chooseBt.backgroundColor = [UIColor clearColor];
            }
        }
    }
    //事件处理
    self.chooseHeaderBtAction(index);
}
#pragma mark - Timer
- (void)startTimer {
    if ((!self.timer) || (![self.timer isValid])) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.00
                                                      target:self
                                                    selector:@selector(poolTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)poolTimer
{
    if ((self.session) && (self.session.state == kSessionStateStart))
    {
        if (remainingTime==0) {
            [self stopTimer];
            return;
        }
        remainingTime--;
        circleProgressView.remainingTime = remainingTime;
        circleProgressView.elapsedTime = kLimitTime - remainingTime;
    }
}
-(void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
