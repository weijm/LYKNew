//
//  PositionShowTableViewCell.m
//  职位展示的cell
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionShowTableViewCell.h"
#import "UIButton+Custom.h"
@implementation PositionShowTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        positionImgWidth.constant = positionImgWidth.constant+3;
        positionImgHeight.constant = positionImgHeight.constant+3;
    }
    if (kIphone4||kIphone5) {
        positionTitle.font = [UIFont systemFontOfSize:15];
        positionInfo.font = [UIFont systemFontOfSize:11];
        positoinName.font = [UIFont systemFontOfSize:13];
        validTimeLab.font = [UIFont systemFontOfSize:11];
    }
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
        urgentImg.hidden = NO;
        validTimeLab.hidden = YES;
        bgToTop.constant = 18;
        bgToBottom.constant = 5;
        
        resumeNumberImg.hidden = YES;
        resumeNumberLab.text = [NSString stringWithFormat:@"%d份",resumeNumber+10];
    }
    positionTitle.text = [dictionary objectForKey:@"job"];
    positoinName.text = [dictionary objectForKey:@"name"];
    positionInfo.text = [NSString stringWithFormat:@"%@ | %@ | %@",[dictionary objectForKey:@"categray"],[dictionary objectForKey:@"money"],[dictionary objectForKey:@"pro"]];
    validTimeLab.text = [dictionary objectForKey:@"time"];
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


@end
