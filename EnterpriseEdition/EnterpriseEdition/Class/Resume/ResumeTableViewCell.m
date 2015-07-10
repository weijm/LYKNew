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
    
    [self initHeaderView];
    [self initMiddleView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadSubView:(NSArray*)array
{
    //初始化headerView数据
    
    //初始化middleView数据
    
    //初始化标签视图
    [self initBottomView:array];
}

-(void)initHeaderView
{
    CGRect frame = CGRectMake(0, 0, kWidth - [Util myXOrWidth:Edge]*2, kHeaderViewH);
    headerView = [[CellHeaderView alloc] initWithFrame:frame];
    [bg addSubview:headerView];
}

-(void)initMiddleView
{
    CGRect frame = CGRectMake(0, kHeaderViewH, kWidth - [Util myXOrWidth:Edge]*2, kMiddleViewH);
    middleView = [[CellMiddleView alloc] initWithFrame:frame];
    [bg addSubview:middleView];
}
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

@end
