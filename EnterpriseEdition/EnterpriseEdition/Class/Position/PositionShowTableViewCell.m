//
//  PositionShowTableViewCell.m
//  职位展示的cell
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionShowTableViewCell.h"
#import "UIButton+Custom.h"
#import "CircleProgressView.h"

#define kPVHeight [Util myYOrHeight:40]
#define kLimitTime 72*60*60
@implementation PositionShowTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        positionImgWidth.constant = positionImgWidth.constant+3;
        positionImgHeight.constant = positionImgHeight.constant+3;
    }
    positionTitle.font = [UIFont systemFontOfSize:[Util myFontSize:17]];
    positionInfo.font = [UIFont systemFontOfSize:[Util myFontSize:13]];
    positoinName.font = [UIFont systemFontOfSize:[Util myFontSize:15]];
    validTimeLab.font = [UIFont systemFontOfSize:[Util myFontSize:13]];
    resumeNumberLab.font = [UIFont systemFontOfSize:[Util myFontSize:13]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//加载数据
-(void)loadPositionData:(NSDictionary*)dictionary
{
    int urgent = [[dictionary objectForKey:@"urgent"] intValue];
    //简历分数
    int resumeNumber = [[dictionary objectForKey:@"number"] intValue];
    if (urgent > 0) {//不是急招职位
        urgentImg.hidden = YES;
        bgToTop.constant = 8;
        bgToBottom.constant = 15;
        //简历分数标记
        if (resumeNumber >0) {
            resumeNumberImg.hidden = NO;
            resumeNumberLab.text = [NSString stringWithFormat:@"%d份",resumeNumber];
        }else
        {
            resumeNumberImg.hidden = YES;
            resumeNumberLab.text = @"";
        }
        
        //是否显示审核标志
        if (_showCheckImg) {
            urgentImg.hidden = NO;
            NSString *state = [dictionary objectForKey:@"state"];
            
            urgentImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"position_check_state%@",state]];
        }

    }else//是急招职位
    {
        [self initProgressView];
        urgentImg.hidden = NO;
        validTimeLab.hidden = YES;
        bgToTop.constant = 18;
        bgToBottom.constant = 5;
        
        resumeNumberImg.hidden = YES;
        resumeNumberLab.text = [NSString stringWithFormat:@"%d份",resumeNumber+10];
        resumeNumberLab.textColor = [UIColor redColor];
    }
    positionTitle.text = [dictionary objectForKey:@"job_type"];
    positoinName.text = [dictionary objectForKey:@"job_type"];
    positionInfo.text = [NSString stringWithFormat:@"%@ | %@-%@",[dictionary objectForKey:@"work_type"],[dictionary objectForKey:@"salary_min"],[dictionary objectForKey:@"salary_max"]];
   //初始化时间
    [self loadTime:[dictionary objectForKey:@"status"] OverTime:[dictionary objectForKey:@"over_time"] RefreshTime:[dictionary objectForKey:@"refresh_time"]];
  
}
-(void)loadTime:(NSString*)status OverTime:(NSString*)overtime RefreshTime:(NSString*)refreshTime
{
    NSString *time = nil;
    NSString *statusStr = nil;
    if ([status isEqualToString:@"正常"]) {
        statusStr = @"有效期至";
        time = overtime;
    }else if ([status isEqualToString:@"下线"])
    {
        statusStr = @"下线时间";
        time = overtime;
    }else if ([status isEqualToString:@"保存"])
    {
        statusStr = @"保存时间";
        time = refreshTime;
    }else
    {
        statusStr = @"提交时间";
        time = refreshTime;
    }
    validTimeLab.text = [NSString stringWithFormat:@"%@%@",statusStr,time];
}
- (IBAction)chooseAction:(id)sender {
    NSString *string = @"0";
    UIButton_Custom *bt = (UIButton_Custom*)sender;
    if (bt.specialMark == 1) {//从选中到取消
        [bt setImage:[UIImage imageNamed:@"resume_choose_bt"] forState:UIControlStateNormal];
        bt.specialMark = 0;
        string = @"0";
    }else//从未选中到选中
    {
        [bt setImage:[UIImage imageNamed:@"resume_choose_selected_bt"] forState:UIControlStateNormal];
        bt.specialMark = 1;
        string = @"1";
    }
    if ([_delegate respondsToSelector:@selector(clickedChooseBtAction:Selected:)]) {
        [_delegate clickedChooseBtAction:(int)self.tag Selected:string];
    }
    
}
-(void)changeLocation:(BOOL)show Selected:(int)isSelected
{
    float bgX = subView.frame.origin.x;
    if (show) {
        //是否选中的标记
        if (isSelected == 0) {
            [chooseBt setImage:[UIImage imageNamed:@"resume_choose_bt"] forState:UIControlStateNormal];
            chooseBt.specialMark = 0;
        }else
        {
            [chooseBt setImage:[UIImage imageNamed:@"resume_choose_selected_bt"] forState:UIControlStateNormal];
            chooseBt.specialMark = 1;
        }
        //视图位置的修改
        if (bgX==33)
        {
            chooseBg.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                bgToLeft.constant = 40;
                bgToRight.constant = -20;
                chooseBgToLeft.constant = 10;
                
            } completion:^(BOOL finished){
                
            }];
        }
    }else
    {
        [chooseBt setImage:[UIImage imageNamed:@"resume_choose_bt"] forState:UIControlStateNormal];
        chooseBt.specialMark = 0;
        [UIView animateWithDuration:0.25 animations:^{
            bgToLeft.constant = 33;
            bgToRight.constant = 0;
            chooseBgToLeft.constant = -10;
            
        } completion:^(BOOL finished){
            chooseBg.hidden = YES;
        }];
    }
}
//初始化剩余时间进度条
-(void)initProgressView
{
    float pvY = 0;
    circleProgressView = [[CircleProgressView alloc] initWithFrame:CGRectMake((kWidth-kPVHeight)/2,pvY , kPVHeight, kPVHeight)];
    float viewOffY = [Util myYOrHeight:10];
    if (kIphone4||kIphone5) {
        viewOffY = 20;
    }
    circleProgressView.center = CGPointMake(resumeNumberImg.center.x, resumeNumberImg.center.y-viewOffY);
    [rightBg addSubview:circleProgressView];
    
    self.session = [[Session alloc] init];
    self.session.startDate = [NSDate date];
    self.session.finishDate = nil;
    self.session.state = kSessionStateStart;
    
    circleProgressView.timeLimit = kLimitTime;
    
    UIColor *tintColor = [UIColor redColor];
    circleProgressView.status = NSLocalizedString(@"circle-progress-view.status-in-progress", nil);
    circleProgressView.tintColor = tintColor;
    remainingTime = 16*60*60+45*60+30;
    circleProgressView.remainingTime = remainingTime;//剩余时间
    circleProgressView.elapsedTime = kLimitTime-remainingTime;//已过时间
    
    [self startTimer];
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
        NSLog(@"timer zhi kong");
    }
}


@end
