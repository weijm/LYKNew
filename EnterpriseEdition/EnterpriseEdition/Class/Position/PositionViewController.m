//
//  PositionViewController.m
//  职位
//
//  Created by wjm on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionViewController.h"
#import "UIButton+Custom.h"
#import "PositionHeaderView.h"
#import "PositionInfoViewController.h"
#import "FooterView.h"

#define kPHeaderViewHeight [Util myYOrHeight:70]

@interface PositionViewController ()
{
    //编辑按钮
    UIButton_Custom *rightBt;
    //headerView
    PositionHeaderView *headerView;
    
    FooterView *footerView;
    //有效职位的数组
    NSMutableArray *validArray;
    //下线职位的数组
    NSMutableArray *offlineArray;
    
    //待审核职位的数组
    NSMutableArray *toAuditArray;
    
    //选中状态的标记数组
    NSMutableArray *chooseArray;
}
@end

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    //初始化items
    [self initItems];
    
    //初始化headerView
    [self initHeaderView];
    //默认的有效职位类型
    categaryType = 1;
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (categaryType == 1) {
        return [validArray count];
    }else if (categaryType == 2)
    {
        return [offlineArray count];
    }else
    {
        return [toAuditArray count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"PositionShowTableViewCellID";
    PositionShowTableViewCell *cell = (PositionShowTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PositionShowTableViewCell" owner:self options:nil] lastObject];
    }
    //获取数据
    NSDictionary *dictionary = nil;
    if (categaryType == 1) {
        dictionary = [validArray objectAtIndex:indexPath.row];
    }else if (categaryType == 2)
    {
        dictionary = [offlineArray objectAtIndex:indexPath.row];
    }else
    {
        dictionary = [toAuditArray objectAtIndex:indexPath.row];
    }
    cell.delegate = self;
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

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (rightBt.specialMark == 0) {
        return kPHeaderViewHeight;
    }else
    {
        return [Util myYOrHeight:20];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Util myYOrHeight:100];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PositionInfoViewController *piVC = [[PositionInfoViewController alloc] init];
    piVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:piVC animated:YES];
}
#pragma mark - PositionShowTableViewCellDelegate
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

#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"home_setting_btn_n"] forState:UIControlStateNormal];
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

}
-(void)rightAction
{
    if (rightBt.specialMark ==0) {//出现选择按钮
        [rightBt setTitle:@"取消" forState:UIControlStateNormal];
        [rightBt setImage:nil forState:UIControlStateNormal];
        rightBt.specialMark = 1;
        //显示底部的编辑按钮
        [self initFooerView];
        
        
        
    }else
    {//隐藏选中按钮
        [rightBt setTitle:@"" forState:UIControlStateNormal];
        [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
        rightBt.specialMark = 0;
        //取消底部视图
        [footerView cancelFooterView];

        
    }
    [dataTableView reloadData];
}

#pragma mark - 初始化HeaderView
-(void)initHeaderView
{
    headerView = [[PositionHeaderView alloc] initWithFrame:CGRectMake(0, topBarheight, kWidth, kPHeaderViewHeight)];
    __weak PositionViewController *wself = self;
    headerView.chooseHeaderBtAction = ^(NSInteger index){
        PositionViewController *sself = wself;
        [sself chooseAction:index isChooseAll:NO];
    };
    headerView.backgroundColor = kCVBackgroundColor;
    [self.view addSubview:headerView];
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    footerView.tag = 1000;
    //标记加载职位的footerView
    footerView.position = 1;
    //初始化按钮
    [footerView loadEditButton:categaryType];
    //设置除了全选按钮可点击 其余按钮不可点击
    [footerView setButton:[self getEnableBtArray] Enable:NO];
    //点击按钮的触发事件
    __weak PositionViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        PositionViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view.window addSubview:footerView];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = footerView.frame;
        frame.origin.y = kHeight - kFOOTERVIEWH;
        footerView.frame = frame;
    }];
    
}
#pragma mark - 可点或不可点击的按钮数组
-(NSArray*)getEnableBtArray
{
    NSArray *enableArray = nil;
    if (categaryType ==1) {
        enableArray = [NSArray arrayWithObjects:@"20",@"30",@"40", nil];
    }else if (categaryType ==2)
    {
        enableArray = [NSArray arrayWithObjects:@"200",@"300", nil];
    }else
    {
        enableArray = [NSArray arrayWithObjects:@"2000", nil];
    }
    return enableArray;
}
#pragma mark - headerView和fooerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    if(index<10)
    {
        categaryType = (int)index+1;
        [self getData];
//        [dataTableView reloadData];
    }else
    {
        switch (index) {
            case 10:
            case 100:
            case 1000:
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
                NSLog(@"有效职位 刷新");
                break;
            case 30:
                NSLog(@"有效职位 删除");
                break;
            case 40:
                NSLog(@"有效职位 下线");
                break;
            case 200:
                NSLog(@"下线职位 删除选中职位");
                break;
            case 300:
                NSLog(@"下线职位 上线选中职位");
                break;
            case 2000:
                NSLog(@"待审核职位 删除选中职位");
                break;
            
            default:
                break;
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
        validArray = dataArray;
    }else if (categaryType==2)
    {
        offlineArray = dataArray;
    }else
    {
        toAuditArray = dataArray;
    }
    if ([dataArray count]>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    [dataTableView reloadData];
}


@end
