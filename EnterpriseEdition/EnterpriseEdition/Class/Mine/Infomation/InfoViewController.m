//
//  InfoViewController.m
//  信息首页
//
//  Created by wjmon 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoViewController.h"
#import "UIButton+Custom.h"
#import "FooterView.h"
#import "InfoDetailViewController.h"
#import "InfoFiltrateView.h"

@interface InfoViewController ()
{
    UIButton_Custom *rightBt;
    
    FooterView *footerView;
    
    NSMutableArray *chooseArray;
    
    UIButton_Custom *filtrateBt;
    
    InfoFiltrateView *infoFiltrateView;
}
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"信息";
    self.view.backgroundColor = Rgb(230, 244, 253, 1.0);
    //初始化编辑按钮
    [self initItems];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"InfoTableViewCellID";
    InfoTableViewCell *cell = (InfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    //加载视图数据
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    
    [cell loadInfoData:dic];
    //全部选中按钮使用
    cell.tag = indexPath.row;
    NSString *isSelected;
    if (rightBt.specialMark==1) {
        isSelected = [chooseArray objectAtIndex:indexPath.row];
    }else
    {
        isSelected = @"0";
    }
    //加载全部选中按钮的状态
    [cell changeLocation:rightBt.specialMark Selected:[isSelected intValue] ];
    //取消点击cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (kIphone6plus) {
        return 80;
    }
    return [Util myYOrHeight:60];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoDetailViewController *infoDetailVC = [[InfoDetailViewController alloc] init];
    infoDetailVC.infoDictionary = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:infoDetailVC animated:YES];
    
}
#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-30, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    filtrateBt = [[UIButton_Custom alloc] initWithFrame:frame];
    [filtrateBt setImage:[UIImage imageNamed:@"my_info_filtrate_bt"] forState:UIControlStateNormal];
    imageInsets = filtrateBt.imageEdgeInsets;
    filtrateBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
    [filtrateBt addTarget:self action:@selector(filtrateAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:filtrateBt];
    
    rightBt = [[UIButton_Custom alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
    imageInsets = rightBt.imageEdgeInsets;
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
    rightBt.titleLabel.font = [UIFont systemFontOfSize:14];
    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+20, titleInsets.bottom, titleInsets.right-20);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem,rightItem1, nil];
    
}
-(void)leftAction
{
    if(footerView)
    {
        [footerView cancelFooterView];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)filtrateAction
{
    if (filtrateBt.specialMark == 0) {//出现筛选页面
        float viewX = kWidth - 130-[Util myXOrWidth:25];
        
        CGRect  frame = CGRectMake(viewX, 0, 130, 101);
        infoFiltrateView = [[InfoFiltrateView alloc] initWithFrame:frame];
        __weak InfoViewController *wself = self;
        infoFiltrateView.touchAction = ^(int index){
            InfoViewController *sself = wself;
            [sself filtrateViewAction:index];
        };
        [infoFiltrateView showInView:self.view];
        
        filtrateBt.specialMark = 1;
        rightBt.enabled = NO;
    }else
    {
        [infoFiltrateView cancelView];
        filtrateBt.specialMark = 0;
        
        rightBt.enabled = YES;
    }
}
-(void)rightAction
{
    if (rightBt.specialMark ==0) {//出现选择按钮
        [rightBt setTitle:@"取消" forState:UIControlStateNormal];
        [rightBt setImage:nil forState:UIControlStateNormal];
        rightBt.specialMark = 1;
        //显示底部的编辑按钮
        [self initFooerView];
        
        filtrateBt.enabled = NO;
        
    }else
    {//隐藏选中按钮
        [rightBt setTitle:@"" forState:UIControlStateNormal];
        [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
        rightBt.specialMark = 0;
        //取消底部视图
        [footerView cancelFooterView];
        filtrateBt.enabled = YES;
        
    }
    [dataTableView reloadData];
}
-(void)filtrateViewAction:(int)index
{
    if (index == 0) {//点击任何地方时取消了筛选视图
        filtrateBt.specialMark = 0;
        
        rightBt.enabled = YES;
    }else if (index == 1)
    {
        NSLog(@"消息");
    }else
    {
        NSLog(@"通知");
    }
    
    
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    footerView.position = 3;//信息页面加载footerView时 position为3
    //初始化按钮
    [footerView loadEditButton:2];
    //设置除了全选按钮可点击 其余按钮不可点击
    [footerView setButton:[NSArray arrayWithObjects:@"200", nil]Enable:NO];
    //点击按钮的触发事件
    __weak InfoViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        InfoViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view.window addSubview:footerView];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = footerView.frame;
        frame.origin.y = kHeight - kFOOTERVIEWH;
        footerView.frame = frame;
    }];
}
#pragma mark - headerView和fooerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    switch (index) {
        case 100:
        {
            NSString *allString = isAll?@"1":@"0";
            for (int i =0; i < [chooseArray count]; i++) {
                [chooseArray replaceObjectAtIndex:i withObject:allString];
            }
            [dataTableView reloadData];
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:isAll];
        }
            break;
        case 200:
            NSLog(@"选中简历类型 2 取消收藏选中的简历");
            break;
            
        default:
            break;
    }
    
}
#pragma mark - SearchResumeTableViewCellDelegate
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected
{
    [chooseArray replaceObjectAtIndex:index withObject:isSelected];
    //判断是否有选中的简历 进而控制收藏选中简历按钮 和 删除选中按钮是否可点
    for (int i= 0; i< [chooseArray count]; i++) {
        NSString *isSelected = [chooseArray objectAtIndex:i];
        if ([isSelected intValue] == 1) {
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后两个按钮不可点击
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
    }
}

#pragma mark - 获取数据
-(void)getData
{
    dataArray = [[NSMutableArray alloc] init];
    NSString *infoStr = @"消息标题";
    NSString *notiStr = @"通知标题";
    for (int i =0; i < 6; i++) {
        NSString *title = (i%2==0)?infoStr:notiStr;
        NSString *titleStr = [NSString stringWithFormat:@"%@%d",title,i];
        NSString *time = [NSString stringWithFormat:@"15/08/%d",i+10];
        NSString *info = [NSString stringWithFormat:@"消息摘要%d消息摘要%d消息摘要%d消息消息消息消息消息消息",i,i,i];
        NSString *type = (i%2==0)?@"1":@"2";
        
        [dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:titleStr,@"title",info,@"info",type,@"type",time,@"time",nil]];
    }
    
    [dataTableView reloadData];
    chooseArray = [[NSMutableArray alloc] initWithCapacity:[dataArray count]];
    for (int i=0; i< [dataArray count]; i++) {
        [chooseArray addObject:@""];
    }
}

@end
