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
#import "OpenPositionViewController.h"

#define kPHeaderViewHeight [Util myYOrHeight:55]

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
    
    //获取的当前页数
    int currentPage1;
    int currentPage2;
    int currentPage3;
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
    
    
    [dataTableView setupRefresh];
}
-(void)viewDidAppear:(BOOL)animated
{
    currentPage1 = 1;
    currentPage2 = 1;
    currentPage3 = 1;
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
        cell.showCheckImg = NO;
    }else if (categaryType == 2)
    {
        dictionary = [offlineArray objectAtIndex:indexPath.row];
        cell.showCheckImg = NO;
    }else
    {
        dictionary = [toAuditArray objectAtIndex:indexPath.row];
        cell.showCheckImg = YES;
    }
    //加载数据
    [cell loadPositionData:dictionary];
    
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
    return kPHeaderViewHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dictionary ;
    if (categaryType == 1) {
        dictionary = [validArray objectAtIndex:indexPath.row];
    }else if (categaryType == 2)
    {
        dictionary = [offlineArray objectAtIndex:indexPath.row];
    }else
    {
        dictionary = [toAuditArray objectAtIndex:indexPath.row];
    }
     int urgent = [[dictionary objectForKey:@"urgent"] intValue];
    if (urgent > 0) {
        return [Util myYOrHeight:103];
    }else
    {
       
        return [Util myYOrHeight:100];
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //恢复 非编辑状态
    if (rightBt.specialMark ==1) {
        [self rightAction];
    }
    
    //查看简历详情
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
    [leftBt setImage:[UIImage imageNamed:@"position_add_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-15, imageInsets.bottom, imageInsets.right+20);
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
    NSString * iid = KGETOBJ(KIID);
    if ([iid intValue]<1) {
        [Util showPrompt:@"您还未提交资料审核，暂不能发布职位"];
        return;
    }
    OpenPositionViewController *openpVC = [[OpenPositionViewController alloc] init];
    openpVC.fromPositionManager = YES;
    openpVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:openpVC animated:YES];

}
-(void)rightAction
{
    if (rightBt.specialMark ==0) {//出现选择按钮
        [rightBt setTitle:@"取消" forState:UIControlStateNormal];
        [rightBt setImage:nil forState:UIControlStateNormal];
        rightBt.specialMark = 1;
        //隐藏tabbar
        self.tabBarController.tabBar.hidden = YES;
        //显示底部的编辑按钮
        [self initFooerView];
        headerView.userInteractionEnabled = NO;
        
        
        
    }else
    {//隐藏选中按钮
        [rightBt setTitle:@"" forState:UIControlStateNormal];
        [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
        rightBt.specialMark = 0;
        //显示tabbar
        self.tabBarController.tabBar.hidden = NO;
        //取消底部视图
        [footerView cancelFooterView];
        headerView.userInteractionEnabled = YES;

        
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
        currentPage1 = 1;
        currentPage2 = 1;
        currentPage3 = 1;
        categaryType = (int)index+1;
        //获取数据
        [self getData];
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
    int page = 1;
    int status = 0;
    switch (categaryType) {
        case 1:
            page = currentPage1;
            status = 0;
            break;
        case 2:
            page = currentPage2;
            status = 1;
            break;
        case 3:
            page = currentPage3;
            status = -1;
            break;
        default:
            break;
    }
    [self showHUD:@"正在加载数据"];
    NSString *listJson = [CombiningData getPositionList:(page+1) Status:status];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                //加载首页数据
                NSArray *dataArr = [result objectForKey:@"data"];
                //全选数组标记
                if(page==1)
                {   //如果第一页 加载的时候 初始化 chooseArray 否则直接增加到数组中
                    chooseArray = [[NSMutableArray alloc] init];
                }
                for (int i=0; i< [dataArr count]; i++) {
                    [chooseArray addObject:@""];
                }
                [self dealWithResponeData:dataArr];
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                if ([message length]==0) {
                    message = @"数据为空";
                }
                [self hideHUDFaild:message];
                NSLog(@"message == %@",[result objectForKey:@"message"]);
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
            NSLog(@"%@",error);
        }
    };
}
-(void)dealWithResponeData:(NSArray*)array
{
    NSArray *dataArray = nil;
    switch (categaryType) {
        case 1:
            validArray = [NSMutableArray arrayWithArray:array];
            currentPage1++;
            dataArray = validArray;
            break;
        case 2:
            offlineArray = [NSMutableArray arrayWithArray:array];
            currentPage2++;
            dataArray = offlineArray;
            break;
        case 3:
            toAuditArray = [NSMutableArray arrayWithArray:array];
            currentPage3++;
            dataArray = toAuditArray;
            break;
        default:
            break;
    }
    [dataTableView reloadData];
    if ([dataArray count]>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

@end
