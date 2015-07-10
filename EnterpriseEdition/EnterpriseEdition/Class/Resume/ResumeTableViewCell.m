//
//  ResumeTableViewCell.m
//  简历自定义cell
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ResumeTableViewCell.h"
#import "CellHeaderView.h"
#import "CellMiddleView.h"
#import "CellBottomView.h"


#define LabCount 4
#define Edge 10

@implementation ResumeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    bg.layer.cornerRadius = 5;
    collectdBg.layer.cornerRadius = 5;
    deleteBg.layer.cornerRadius = 5;
    
    [self initHeaderView];
    [self initMiddleView];
    
    //添加向右滑动手势
    UISwipeGestureRecognizer *rightSwipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    rightSwipGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipGestureRecognizer];
    //添加向左滑动手势
    UISwipeGestureRecognizer *leftSwipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    leftSwipGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadSubView:(NSDictionary*)dictionary
{
    //初始化headerView数据
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [dic removeObjectForKey:@"sign"];
    [headerView loadData:dic];
    //初始化middleView数据
    [middleView loadData:dic];
    
    //初始化标签视图
    NSArray *array = [NSArray arrayWithArray:[dictionary objectForKey:@"sign"]];
    [self initBottomView:array];
}
//初始化headerView
-(void)initHeaderView
{
    CGRect frame = CGRectMake(0, 0, kWidth - [Util myXOrWidth:Edge]*2, kHeaderViewH);
    headerView = [[CellHeaderView alloc] initWithFrame:frame];
    [bg addSubview:headerView];
}
//初始化middleView
-(void)initMiddleView
{
    CGRect frame = CGRectMake(0, kHeaderViewH, kWidth - [Util myXOrWidth:Edge]*2, kMiddleViewH);
    middleView = [[CellMiddleView alloc] initWithFrame:frame];
    [bg addSubview:middleView];
}
//初始化bottomView
-(void)initBottomView:(NSArray*)array
{
    CellBottomView *tempView = (CellBottomView *)[bg viewWithTag:10000];
    [tempView removeFromSuperview];
    
    int  count = (int)array.count;
    int row = [Util getRow:count eachCount:LabCount];;
    
    float labbgH = kBottomEachH*row;

    CGRect frame = CGRectMake(0, kHeaderViewH+kMiddleViewH+[Util myYOrHeight:1], kWidth - [Util myXOrWidth:Edge]*2, labbgH);
    CellBottomView *bottomView = [[CellBottomView alloc] initWithFrame:frame];
    bottomView.tag = 10000;
    [bottomView loadAllLabel:array];
    [bg addSubview:bottomView];
    
}
//手势响应事件
-(void)swipAction:(UISwipeGestureRecognizer*)sender
{
    float offsetX = [Util myXOrWidth:80];

    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        float bgX = bg.frame.origin.x;
        if (bgX==10) {
            collectdBg.hidden = NO;
            if ([_delegate respondsToSelector:@selector(revertLeftOrRightSwipView:selected:)]) {
                [_delegate revertLeftOrRightSwipView:self selected:YES ];
            }
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = collectdBg.frame;
                frame.origin.x = bg.frame.origin.x;
                collectdBg.frame = frame;
                frame = bg.frame;
                frame.origin.x = frame.origin.x+offsetX;
                bg.frame = frame;
            } completion:^(BOOL finished){}];
        }else if (bgX<10)
        {
            if ([_delegate respondsToSelector:@selector(revertLeftOrRightSwipView:selected:)]) {
                [_delegate revertLeftOrRightSwipView:self selected:NO ];
            }
            [self revertView];
        }
    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        float bgX = bg.frame.origin.x;
        if (bgX==10) {
            deleteBg.hidden = NO;
            if ([_delegate respondsToSelector:@selector(revertLeftOrRightSwipView:selected:)]) {
                [_delegate revertLeftOrRightSwipView:self selected:YES ];
            }
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = deleteBg.frame;
                frame.origin.x = frame.origin.x-offsetX;
                deleteBg.frame = frame;
                frame = bg.frame;
                frame.origin.x = frame.origin.x-offsetX;
                bg.frame = frame;
            } completion:^(BOOL finished){}];
        }else if (bgX>10)
        {//还原收藏
            if ([_delegate respondsToSelector:@selector(revertLeftOrRightSwipView:selected:)]) {
                [_delegate revertLeftOrRightSwipView:self selected:NO ];
            }
            [self revertView];
        }
    }
}
-(void)revertView
{
    float offsetX = [Util myXOrWidth:80];
    float bgX = bg.frame.origin.x;
    if (bgX<10)
    {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = bg.frame;
            frame.origin.x = frame.origin.x+offsetX;
            bg.frame = frame;
            frame = deleteBg.frame;
            frame.origin.x = frame.origin.x+offsetX;
            deleteBg.frame = frame;
            
        } completion:^(BOOL finished){
            deleteBg.hidden = YES;
        }];

    }
    
    if (bgX>10)
    {//还原收藏
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = bg.frame;
            frame.origin.x = frame.origin.x-offsetX;
            bg.frame = frame;
            frame = collectdBg.frame;
            frame.origin.x = frame.origin.x-offsetX;
            collectdBg.frame = frame;
            
        } completion:^(BOOL finished){
            collectdBg.hidden = YES;
        }];
    }
}
@end
