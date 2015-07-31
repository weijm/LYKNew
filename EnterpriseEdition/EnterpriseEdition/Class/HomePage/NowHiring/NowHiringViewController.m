//
//  NowHiringViewController.m
//  急招
//
//  Created by wjm on 15/7/17.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "NowHiringViewController.h"
#import "UIButton+Custom.h"
#import "FooterView.h"
#import "NowHiringHeaderView.h"
#define kNHeaderViewHeight [Util myYOrHeight:70]
@interface NowHiringViewController ()
{
    NSMutableArray *chooseArray;
    
    UIButton_Custom *rightBt;
    
    FooterView *footerView;
    
    NowHiringHeaderView *headerView;
}
@end

@implementation NowHiringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    self.title = @"急招";
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    //初始化headerView
    [self initHeaderView];
    
    //设置tableView
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorColor = [UIColor clearColor];
    
    //初始化items
    [self initItems];

    
    categaryType = 1;
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (categaryType==1) {
        return [receivedArray count];
    }else
    {
        return [commendArray count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"NowHiringCellId";
    NowHiringTableViewCell *cell = (NowHiringTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NowHiringTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    NSDictionary *dic ;
    if (categaryType == 1) {
        dic = [receivedArray objectAtIndex:indexPath.row];
    }else
    {
        dic = [commendArray objectAtIndex:indexPath.row];
    }
    [cell loadData:dic Type:categaryType];
    
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
    return kHeaderViewH+ kMiddleViewH + [Util myYOrHeight:3];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (rightBt.specialMark == 0) {
        return kNHeaderViewHeight;
    }else
    {
        return [Util myYOrHeight:8];
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (rightBt.specialMark == 0) {
        headerView.hidden = NO;
    }else
    {
        headerView.hidden = YES;
    }

    return headerView;
}
#pragma mark - 初始化headerView
-(void)initHeaderView
{
    headerView = [[NowHiringHeaderView alloc] initWithFrame:CGRectMake(0, topBarheight, kWidth, kNHeaderViewHeight)];
    __weak NowHiringViewController *wself = self;
    headerView.chooseHeaderBtAction = ^(NSInteger index){
        NowHiringViewController *sself = wself;
        [sself chooseAction:index isChooseAll:NO];
    };
    headerView.backgroundColor = kCVBackgroundColor;
    [self.view addSubview:headerView];
}
#pragma mark  -NowHiringTableViewCellDelegate
//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected
{
    [chooseArray replaceObjectAtIndex:index withObject:isSelected];
    //判断是否有选中的简历 进而控制收藏选中简历按钮 和 删除选中按钮是否可点
    for (int i= 0; i< [chooseArray count]; i++) {
        NSString *isSelected = [chooseArray objectAtIndex:i];
        if ([isSelected intValue] == 1) {
            [footerView setButton:[self getEnableBtArray] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后两个按钮不可点击
            [footerView setButton:[self getEnableBtArray] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
    }

}
#pragma mark - 获取数据
-(void)getData
{
   NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    NSString *jobStr = @"软件工程师";
    
    for (int i =0; i < 6; i++) {
        NSString *job = [NSString stringWithFormat:@"%@%d",jobStr,i];
        NSString *time = [NSString stringWithFormat:@"08-%d",i+10];
        NSString *name = [NSString stringWithFormat:@"张晓%d",i];
        NSString *age = [NSString stringWithFormat:@"%d",i];
        NSString *money = [NSString stringWithFormat:@"%d-%d",500*(i+1),800*(i+1)];
        NSString *exp = (i%3==0)?@"有工作经验":@"";
        NSString *urgent = @"0";
        NSString *colledted = @"0";
        NSString *download = @"0";
        
        [dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:job,@"job",urgent,@"urgent",colledted,@"collected",download,@"download",time,@"time",name,@"name",@"女",@"sex",@"UI设计师",@"selfjob",age,@"age",@"本科",@"record",money,@"money",@"艺术设计",@"professional",@"中国传媒大学",@"school",exp,@"experience",nil]];
    }
    
    
    chooseArray = [[NSMutableArray alloc] initWithCapacity:[dataArray count]];
    for (int i=0; i< [dataArray count]; i++) {
        [chooseArray addObject:@""];
    }
    if (categaryType==1) {
        receivedArray = dataArray;
    }else
    {
        commendArray = dataArray;
    }
    if ([dataArray count]>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    [dataTableView reloadData];
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
    
    rightBt = [[UIButton_Custom alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
    imageInsets = rightBt.imageEdgeInsets;
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
    rightBt.titleLabel.font = [UIFont systemFontOfSize:14];
    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+20, titleInsets.bottom, titleInsets.right-20);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}
-(void)leftAction
{
    if(footerView)
    {
        [footerView cancelFooterView];
    }
    
    if (headerView) {
        [headerView stopTimer];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction
{
    if (rightBt.specialMark ==1) {
        if (chooseArray) {
            [chooseArray removeAllObjects];
        }
        
        [rightBt setTitle:@"" forState:UIControlStateNormal];
        [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
        rightBt.specialMark = 0;
        //取消底部视图
        [footerView cancelFooterView];
        
    }else
    {
        int count;
        if (categaryType == 1) {
            count = (int)[receivedArray count];
        }else
        {
            count = (int)[commendArray count];
        }
        chooseArray = [[NSMutableArray alloc] initWithCapacity:count];
        for (int i = 0; i<count;i++) {
            [chooseArray addObject:@"0"];
        }
        
        [rightBt setTitle:@"取消" forState:UIControlStateNormal];
        [rightBt setImage:nil forState:UIControlStateNormal];
        rightBt.specialMark = 1;
        //显示底部的编辑按钮
        [self initFooerView];

    }
    [dataTableView reloadData];

}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    //初始化按钮
    [footerView loadEditButton:categaryType];
    //设置除了全选按钮可点击 其余按钮不可点击
    [footerView setButton:[self getEnableBtArray] Enable:NO];
    //点击按钮的触发事件
    __weak NowHiringViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        NowHiringViewController *sself = wself;
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
    if(index<10)
    {
        categaryType = (int)index+1;
        [self getData];
        [dataTableView reloadData];
    }else
    {
        switch (index) {
            case 10:
            case 100:
            {
                NSString *allString = isAll?@"1":@"0";
                for (int i =0; i < [chooseArray count]; i++) {
                    [chooseArray replaceObjectAtIndex:i withObject:allString];
                }
                [dataTableView reloadData];
                [footerView setButton:[self getEnableBtArray] Enable:isAll];
            }
                break;
            case 20:
                NSLog(@"选中简历类型 1 收藏选中的简历");
                break;
            case 30:
                NSLog(@"选中简历类型 1 删除选中的简历");
                break;
            case 200:
                NSLog(@"选中简历类型 2 取消收藏选中的简历");
                break;
            default:
                break;
        }

    }
    
}
#pragma mark - 可点或不可点击的按钮数组
-(NSArray*)getEnableBtArray
{
    NSArray *enableArray = nil;
    if (categaryType ==1) {
        enableArray = [NSArray arrayWithObjects:@"20",@"30", nil];
    }else
    {
        enableArray = [NSArray arrayWithObjects:@"200", nil];
    }
    return enableArray;
}
@end
