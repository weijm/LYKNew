//
//  JobFairListView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/9/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "JobFairListView.h"

@implementation JobFairListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame AndData:(NSArray*)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        dataArray = [NSArray arrayWithArray:array];
        
        [self initTopView];
        [self initDataView];
        [self initFooterView];
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        chooseArray = [NSMutableArray array];
        for (int i = 0; i < [dataArray count]; i++) {
            [chooseArray addObject:@"0"];
        }
        
    }
    return self;
}
-(void)initTopView
{
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [Util myYOrHeight:40])];
    titLab.text = @"选择招聘会";
    titLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    titLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titLab];
    
    UIButton *cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-[Util myXOrWidth:30], 0, [Util myXOrWidth:30], [Util myXOrWidth:30])];
    [cancelBt setImage:[UIImage imageNamed:@"position_close_bt.png"] forState:UIControlStateNormal];
    [cancelBt addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBt];
}
-(void)initDataView
{
    dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [Util myXOrWidth:40], self.frame.size.width, [Util myYOrHeight:35]*2)];
    dataTableView.delegate = self;
    dataTableView.dataSource = self;
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorColor = [UIColor clearColor];
   
    [self addSubview:dataTableView];
}
-(void)initFooterView
{
    float lineY = dataTableView.frame.origin.y+dataTableView.frame.size.height;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,lineY, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.25;
    [self addSubview:lineView];
    
    UIButton *makeSureBt = [[UIButton alloc] initWithFrame:CGRectMake(0, lineY+0.5, self.frame.size.width, [Util myYOrHeight:40]-0.5)];
    [makeSureBt setTitle:@"确 定" forState:UIControlStateNormal];
    [makeSureBt setTitleColor:Rgb(2, 139, 230, 1.0) forState:UIControlStateNormal];
    makeSureBt.titleLabel.font = [UIFont systemFontOfSize:17];
    [makeSureBt addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:makeSureBt];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [Util myYOrHeight:35])];
    selectedView.backgroundColor = Rgb(2, 139, 230, 1.0);
    cell.selectedBackgroundView = selectedView;

    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    if (indexPath.row < [dataArray count]-1) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, [Util myYOrHeight:35]-0.5, kWidth, 0.5)];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.25;
        [cell.contentView addSubview:line];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Util myYOrHeight:35];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedStr = [chooseArray objectAtIndex:indexPath.row];
    if ([selectedStr intValue]==1) {
        [chooseArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    }else
    {
        [chooseArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    
    for (int i =0; i < [chooseArray count]; i++) {
        NSString *var = [chooseArray objectAtIndex:i];
        if (i != indexPath.row&&[var intValue]==1) {
            [chooseArray replaceObjectAtIndex:i withObject:@"0"];
        }
    }
}
#pragma mark -
-(float)getLabFontSize
{
    if (kIphone6||kIphone6plus) {
        return 15;
    }else
    {
        return 14;
    }
}
#pragma mark - 展示和取消视图
-(void)showView:(UIView *)view
{
    UIView *areaBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, view.frame.size.height)];
    areaBg.backgroundColor = [UIColor clearColor];
    areaBg.tag = 250;
    [view addSubview:areaBg];
    
    UIView *alphBg = [[UIView alloc] initWithFrame:view.frame];
    alphBg.backgroundColor = [UIColor blackColor];
    alphBg.alpha = 0;
    [areaBg addSubview:alphBg];
    

    [view addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
        alphBg.alpha = 0.2;
        self.alpha = 1.0;
        
        
    }];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)];
//    [areaBg addGestureRecognizer:tap];
}
-(void)cancelView
{
    UIView *supView = [self superview];
    UIView *areaBg = [supView viewWithTag:250];
    [UIView animateWithDuration:0.3 animations:^{
        areaBg.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished){
        [areaBg removeFromSuperview];
        [self removeFromSuperview];
        if ([_delegate respondsToSelector:@selector(cancelAction)]) {
            [_delegate cancelAction];
        }
    }];
}
-(void)makeSure
{
    for (int i =0; i< [chooseArray count]; i++) {
        NSString *var = [chooseArray objectAtIndex:i];
        NSDictionary *dic = [dataArray objectAtIndex:i];
        if ([var intValue]==1) {
            if ([_delegate respondsToSelector:@selector(makeSureAction:)]) {
                [_delegate makeSureAction:[dic objectForKey:@"id"]];
            }
            return;
        }else if (i== [chooseArray count]-1)
        {
            [Util showPrompt:@"请选择招聘会"];
        }
    }
}
@end
