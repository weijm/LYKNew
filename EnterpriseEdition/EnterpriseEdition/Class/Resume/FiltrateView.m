//
//  FiltrateView.m
//  筛选条件页面
//
//  Created by wjm on 15/7/13.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "FiltrateView.h"
#import "FiltrateTableViewCell.h"


@implementation FiltrateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"FiltrateView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        self.backgroundColor = kCVBackgroundColor;
        
        tableViewToTop.constant = [Util myYOrHeight:17];
        
        filtrateTableView.separatorColor = [UIColor clearColor];
        filtrateTableView.backgroundColor = [UIColor clearColor];
        titleArray = [[NSMutableArray alloc] initWithObjects:@"按 职  位",@"学      历",@"期望薪资",@"专      业",@"职位类型",@"期望城市",@"工作经验", nil];
        contentArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
        filtrateTableView.tableFooterView = [self footerView];
    }
    return self;
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"FiltrateCellId";
    FiltrateTableViewCell *cell = (FiltrateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FiltrateTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tag = indexPath.row;
    NSString *titleString = [titleArray objectAtIndex:indexPath.row];
    if ([titleString isEqualToString:@"简历来源"]) {
        cell.backgroundColor = [UIColor clearColor];
        cell.titleLab.hidden = YES;
        cell.contentBg.hidden = YES;
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLab.hidden = NO;
        cell.contentBg.hidden = NO;
    }
    cell.titleLab.text = titleString;
    if (isReset) {
        //重置编辑视图
        [cell resetEditTextField];
    }else
    {
        //对编辑视图赋值
        NSObject *obj = [contentArray objectAtIndex:indexPath.row];
        [cell setEditContent:obj];
       
    }
    //取消点击cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didSelectedRow:)]) {
        [_delegate didSelectedRow:(int)indexPath.row];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Util myYOrHeight:32.5];
}
#pragma mark - TableFooterView
-(UIView*)footerView
{
    float cellH ;
    if (kIphone4) {
        cellH = 40;
    }else
    {
        cellH =50;
    }
    float footerH = self.frame.size.height - cellH*7;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, footerH)];
    footer.userInteractionEnabled = YES;
    UIButton *filtrateBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [Util myXOrWidth:95], [Util myYOrHeight:28])];
    filtrateBt.center = footer.center;
    [filtrateBt setTitle:@"重置筛选条件" forState:UIControlStateNormal];
    [filtrateBt setTitleColor:Rgb(0, 0, 0, 0.7) forState:UIControlStateNormal];
    filtrateBt.backgroundColor = [UIColor whiteColor];
    filtrateBt.layer.borderWidth = 0.25;
    filtrateBt.layer.cornerRadius = 3;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.694, 0.694, 0.714, 1 });
    filtrateBt.layer.borderColor = colorref;
    filtrateBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [filtrateBt addTarget:self action:@selector(resetFiltrate) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:filtrateBt];
    return footer;
}
//根据选择不同的简历筛选标题不同
-(void)changeTitleArray:(int)index
{
    if (index == 1) {//收到的简历筛选标题
        [titleArray replaceObjectAtIndex:0 withObject:@"按 职  位"];
    }else if (index ==2)
    {
        [titleArray replaceObjectAtIndex:0 withObject:@"简历来源"];
    }else
    {
        [titleArray replaceObjectAtIndex:0 withObject:@"简历来源"];
    }
    [filtrateTableView reloadData];
}
//重置筛选条件
-(void)resetFiltrate
{
    isReset = YES;
    [filtrateTableView reloadData];
    //重置时 确认按钮不可点击
    sureBt.enabled = NO;
    //被编辑个数置为0
    editCount = 0;
}
//确认的触发事件
- (IBAction)makeSure:(id)sender {
    if ([_delegate respondsToSelector:@selector(makeSureOrCancelAction:Conditions:)]) {
        [_delegate makeSureOrCancelAction:YES Conditions:contentArray];
        
    }
}
- (IBAction)cancelFiltrateView:(id)sender {
    if ([_delegate respondsToSelector:@selector(makeSureOrCancelAction:Conditions:)]) {
        [_delegate makeSureOrCancelAction:NO Conditions:nil];
    }
}

// 刷新指定行
-(void)reloadTableView:(int)row withContent:(NSDictionary*)contentDic
{
    //只要编辑了某一行，就将重置标志赋值为NO
    isReset = NO;
    
    if (contentDic) {//编辑数据不为空
        //编辑个数加1
        editCount++;
        [contentArray replaceObjectAtIndex:row withObject:contentDic];
    }else
    {
        //编辑个数减1
        editCount = (editCount >0)?editCount--:0;
        [contentArray replaceObjectAtIndex:row withObject:@""];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    //刷新某一行
    [filtrateTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath , nil] withRowAnimation:UITableViewRowAnimationNone];
    
    //设置确认按钮可点
    if (editCount==0) {
        sureBt.enabled = NO;
    }else
    {
        sureBt.enabled = YES;
    }
}


@end
