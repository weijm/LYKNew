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

@implementation ResumeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    bg.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadSubView:(NSArray*)array
{
    [self initHeaderView];
    [self initMiddleView];
    [self initBottomView:array];
}

-(void)initHeaderView
{
    CGRect frame = CGRectMake(0, 0, kWidth - [Util myXOrWidth:5]*2, kHeaderViewH);
    CellHeaderView *headerView = [[CellHeaderView alloc] initWithFrame:frame];
    [bg addSubview:headerView];
}

-(void)initMiddleView
{
    CGRect frame = CGRectMake(0, kHeaderViewH, kWidth - [Util myXOrWidth:5]*2, kMiddleViewH);
    CellMiddleView *middleView = [[CellMiddleView alloc] initWithFrame:frame];
    [bg addSubview:middleView];
}
-(void)initBottomView:(NSArray*)array
{
    int  count = (int)array.count;
    int row = [Util getRow:count eachCount:LabCount];;
    
    float labbgH = kBottomEachH*row;
    NSLog(@"initBottomView row == %f",labbgH);
    
    CGRect frame = CGRectMake(0, kHeaderViewH+kMiddleViewH+[Util myYOrHeight:1], kWidth - [Util myXOrWidth:5]*2, labbgH);
    CellBottomView *bottomView = [[CellBottomView alloc] initWithFrame:frame];
    [bottomView loadAllLabel:array];
    [bg addSubview:bottomView];
    
}
@end
