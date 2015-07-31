//
//  InfoTableViewCell.m
//  消息的Cell
//
//  Created by wjm on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "UIButton+Custom.h"
@implementation InfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        iconWidth.constant = iconWidth.constant +3;
        iconHeight.constant = iconHeight.constant +3;
    }
    blineWidth.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//加载数据
-(void)loadInfoData:(NSDictionary*)dictionary
{
    if ([[dictionary objectForKey:@"type"] intValue]==1) {
        iconImg.image = [UIImage imageNamed:@"my_info_icon"];
    }else
    {
        iconImg.image = [UIImage imageNamed:@"my_notification_icon"];
    }
    titleLab.text = [dictionary objectForKey:@"title"];
    infoLab.text = [dictionary objectForKey:@"info"];
    timeLab.text = [dictionary objectForKey:@"time"];
    

}
//选中按钮的点击事件
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
//全选时 出现选择按钮
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
        if (bgX==0)
        {
            chooseBg.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                bgToLeft.constant = 29;
                bgToRight.constant = -29;
                chooseBgToLeft.constant = 1;
                
            } completion:^(BOOL finished){
                
            }];
        }
    }else
    {
        [chooseBt setImage:[UIImage imageNamed:@"resume_choose_bt"] forState:UIControlStateNormal];
        chooseBt.specialMark = 0;
        [UIView animateWithDuration:0.25 animations:^{
            bgToLeft.constant = 0;
            bgToRight.constant = 0;
            chooseBgToLeft.constant = -34;
            
        } completion:^(BOOL finished){
            chooseBg.hidden = YES;
        }];
    }
}

@end
