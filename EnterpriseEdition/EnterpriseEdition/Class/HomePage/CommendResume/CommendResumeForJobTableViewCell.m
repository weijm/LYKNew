//
//  CommendResumeForJobTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CommendResumeForJobTableViewCell.h"
#import "UIButton+Custom.h"
#define Edge 10
@implementation CommendResumeForJobTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initHeaderView];
    [self initMiddleView];
    _isShowRateView = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//初始化headerView
-(void)initHeaderView
{
    CGRect frame = CGRectMake(0, 0, kWidth - [Util myXOrWidth:Edge]*2, kHeaderViewH);
    headerView = [[CellHeaderView alloc] initWithFrame:frame];
    headerView.showRateView = YES;
    [subView addSubview:headerView];
}
//初始化middleView
-(void)initMiddleView
{
    CGRect frame = CGRectMake(0, kHeaderViewH, kWidth - [Util myXOrWidth:Edge]*2, kMiddleViewH);
    middleView = [[CellMiddleView alloc] initWithFrame:frame];
    [subView addSubview:middleView];
}
//加载数据
-(void)loadSearchResumeData:(NSDictionary*)dictionary
{
    [headerView loadData:dictionary];
    //初始化middleView数据
    [middleView loadData:dictionary];
    NSLog(@"_isShowRateView==%d",_isShowRateView);
    if (!_isShowRateView) {
        headerView.showRateView = NO;
    }
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
        if (bgX==10)
        {
            chooseBg.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                bgToLeft.constant = 30;
                bgToRight.constant = -10;
                chooseBgToLeft.constant = 5;
                
            } completion:^(BOOL finished){
                
            }];
        }
    }else
    {
        [chooseBt setImage:[UIImage imageNamed:@"resume_choose_bt"] forState:UIControlStateNormal];
        chooseBt.specialMark = 0;
        [UIView animateWithDuration:0.25 animations:^{
            bgToLeft.constant = 10;
            bgToRight.constant = 10;
            chooseBgToLeft.constant = -20;
            
        } completion:^(BOOL finished){
            chooseBg.hidden = YES;
        }];
    }
}

@end
