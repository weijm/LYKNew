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
    
    //是否正在加载数据
    BOOL isLoading;
}
@end

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    //初始化items
    [self initItems];
    
    
    //默认的有效职位类型
    if (categaryType==0) {
        categaryType = 1;
    }
    
    //初始化headerView
    [self initHeaderView];
    
    [dataTableView setupRefresh];
    dataTableView.refreshData = ^{
        [self refreshData];
    };
    
    isLoading = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:kLoginOut object:nil];
    
}
-(void)loginOut:(NSNotification*)notifiCation
{
    BOOL isLoginOut = [[notifiCation object] boolValue];
    if (isLoginOut) {
        validArray = nil;
        offlineArray = nil;
        toAuditArray = nil;
        chooseArray = nil;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [dataTableView reloadData];
    }else
    {
        currentPage1 = 1;
        currentPage2 = 1;
        currentPage3 = 1;
        [self getData];
    }
}
//从首页点击进入
-(void)loadStatusFromHomePage:(int)index
{
    categaryType = index;
    if (headerView) {
        [headerView changeButtonBgAndTextColor:index-1];
    }
    
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
    NSMutableDictionary *dictionary = nil;
    if (categaryType == 1) {
        dictionary = [NSMutableDictionary dictionaryWithDictionary:[validArray objectAtIndex:indexPath.row]];
        cell.isShowTimeLab = YES;
        cell.showCheckImg = NO;
        
    }else if (categaryType == 2)
    {
        dictionary = [offlineArray objectAtIndex:indexPath.row];
        cell.isShowTimeLab = NO;
        cell.showCheckImg = NO;
    }else
    {
        dictionary = [toAuditArray objectAtIndex:indexPath.row];
        cell.isShowTimeLab = YES;
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
    if (categaryType == 2)
    {
        return [Util myYOrHeight:80];
    }
    else
    {
        return [Util myYOrHeight:100];
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) {//正在加载数据的时候 不可以点击进入详情
        return;
    }
    //恢复 非编辑状态
    if (rightBt.specialMark ==1) {
        return;
    }
    NSDictionary *dictionary = nil;
    if (categaryType ==1) {
        dictionary = [validArray objectAtIndex:indexPath.row];
    }else if(categaryType ==2)
    {
        dictionary = [offlineArray objectAtIndex:indexPath.row];
    }else
    {
        dictionary = [toAuditArray objectAtIndex:indexPath.row];
    }
    //查看简历详情
    PositionInfoViewController *piVC = [[PositionInfoViewController alloc] init];
    piVC.hidesBottomBarWhenPushed = YES;
    piVC.jobId = [dictionary objectForKey:@"id"];
    piVC.positionStatus = [Util getCorrectString:[dictionary objectForKey:@"status"]];
    
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

    if (rightBt.specialMark == 1) {
        [self rightAction];
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
        //初始化chooseArray
        
        //显示tabbar
        self.tabBarController.tabBar.hidden = NO;
        //取消底部视图
        [footerView cancelFooterView];
        headerView.userInteractionEnabled = YES;
        
        [self revertChooseArray];
        

        
    }
    [dataTableView reloadData];
}
-(void)revertChooseArray
{
    NSArray *tempArray = nil;
    if (categaryType ==1) {
        tempArray = validArray;
    }else if (categaryType == 2)
    {
        tempArray = offlineArray;
    }else
    {
        tempArray = toAuditArray;
    }
    chooseArray = [NSMutableArray array];
    for (int i =0; i < [tempArray count]; i++) {
        [chooseArray addObject:@"0"];
    }
}
#pragma mark - 初始化HeaderView
-(void)initHeaderView
{
    if (headerView) {
        [headerView removeFromSuperview];
        headerView = nil;
    }
    headerView = [[PositionHeaderView alloc] initWithFrame:CGRectMake(0, topBarheight, kWidth, kPHeaderViewHeight)];
    __weak PositionViewController *wself = self;
    headerView.chooseHeaderBtAction = ^(NSInteger index){
        PositionViewController *sself = wself;
        [sself chooseAction:index isChooseAll:NO];
    };
    [headerView changeButtonBgAndTextColor:categaryType-1];
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
        NSArray *dataArray = nil;
        if (categaryType == 1) {
            dataArray = validArray;
        }else if (categaryType == 2)
        {
            dataArray = offlineArray;
        }else
        {
            dataArray = toAuditArray;
        }
        if ([dataArray count]==0) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
//            [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
                
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
            {
                NSMutableArray *refreshArr = [self dealWithBatchData];
                [self batchDealWithPosition:refreshArr Status:-8];//刷新
           
            }
                break;
            case 30:
            {
                NSMutableArray *refreshArr = [self dealWithBatchData];
                [self batchDealWithPosition:refreshArr Status:-9];//删除
            }
                break;
            case 40:
            {
                NSMutableArray *refreshArr = [self dealWithBatchData];
                [self batchDealWithPosition:refreshArr Status:1];//下线
            }
                break;
            case 200:
            {
                NSMutableArray *refreshArr = [self dealWithBatchData];
                [self batchDealWithPosition:refreshArr Status:-9];//删除
            }
                break;
            case 300:
            {
                NSMutableArray *refreshArr = [self dealWithBatchData];
                [self batchDealWithPosition:refreshArr Status:0];//上线
            }
                break;
            case 2000:
            {
                NSMutableArray *refreshArr = [self dealWithBatchData];
                [self batchDealWithPosition:refreshArr Status:-9];//删除
            }
                break;
            
            default:
                break;
        }
    }
}
#pragma mark - 需要批量操作的数据
-(NSMutableArray*)dealWithBatchData
{
    NSArray *tempArray = nil;
    if (categaryType ==1) {
        tempArray = validArray;
    }else if (categaryType == 2)
    {
        tempArray = offlineArray;
    }else
    {
        tempArray = toAuditArray;
    }
    NSMutableArray *dealArray = [NSMutableArray array];
    for (int i = 0; i < [chooseArray count]; i++) {
        NSString *choose = [chooseArray objectAtIndex:i];
        if ([choose intValue]==1) {//被选中的
            NSDictionary * aDic = [tempArray objectAtIndex:i];
            [dealArray addObject:[aDic objectForKey:@"id"]];
        }
    }
    return dealArray;
}
#pragma mark - 获取数据
-(void)getData
{
    [self requestPositionList:NO];
    
}
-(void)dealWithResponeData:(NSArray*)array
{
    NSArray *dataArray = nil;
    switch (categaryType) {
        case 1:
        {
            if (currentPage1>1) {
                [validArray addObjectsFromArray:array];
            }else
            {
                validArray = [NSMutableArray arrayWithArray:array];
            }
            currentPage1++;
            dataArray = validArray;
        }
            break;
        case 2:
        {
            if (currentPage2>1) {
                [offlineArray addObjectsFromArray:array];
            }else
            {
                offlineArray = [NSMutableArray arrayWithArray:array];
            }
            currentPage2++;
            dataArray = offlineArray;
        }
            break;
        case 3:
        {
            if (currentPage3>1) {
                [toAuditArray addObjectsFromArray:array];
            }else
            {
                toAuditArray = [NSMutableArray arrayWithArray:array];
            }
            currentPage3++;
            dataArray = toAuditArray;
        }
            break;
        default:
            break;
    }
    [dataTableView reloadData];
    if ([dataArray count]>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
#pragma mark - 在非编辑状态下 下拉加载更多
- (void)refreshData
{
    if (rightBt.specialMark == 0) {//不处于编辑状态 可以加载更多
        isLoading = YES;
        //请求数据
        [self requestPositionList:YES];
        //本页其他事件不可触发
        [self subViewEnabled:NO];
    }else
    {
        [dataTableView stopRefresh];
    }
}
//停止刷新
-(void)stopRefreshLoading
{
    [dataTableView stopRefresh];
    isLoading = NO;
    [self subViewEnabled:YES];
    [dataTableView changeProText:NO];
}
#pragma mark - 加载数据中 不可以点击本页的事件
-(void)subViewEnabled:(BOOL)enable
{
    self.navigationItem.rightBarButtonItem.enabled = enable;
    self.navigationItem.leftBarButtonItem.enabled = enable;
    headerView.userInteractionEnabled = enable;
}
#pragma mark - 请求服务器
-(void)requestPositionList:(BOOL)isMore
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
    NSString *listJson = [CombiningData getPositionList:page Status:status];;
    if (!isMore) {
        [self showHUD:@"正在加载数据"];
    }
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                //加载首页数据
                NSArray *dataArr = [result objectForKey:@"data"];
                //全选数组标记
                if(page==1)
                {   //如果第一页 加载的时候 初始化 chooseArray 否则直接增加到数组中
                    chooseArray = [NSMutableArray array];
                }
                for (int i=0; i< [dataArr count]; i++) {
                    [chooseArray addObject:@""];
                }
                [self dealWithResponeData:dataArr];
                //将提示视图取消
                if (!isMore) {
                    [self hideHUD];
                }else
                {
                    [dataTableView stopRefresh];
                    isLoading = NO;
                    [self subViewEnabled:YES];
                }
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                
                if (!isMore) {
                    if (categaryType ==1) {
                        validArray = [NSMutableArray array];
//                        message = @"该企业暂无有效职位";
                    }else if (categaryType ==2)
                    {
                        offlineArray = [NSMutableArray array];
//                        message = @"该企业暂无下线的职位";
                    }else
                    {
                        toAuditArray = [NSMutableArray array];
//                        message = @"该企业暂无待审核的职位";
                    }
                    [dataTableView reloadData];
                    [self hideHUDFaild:message];
                }else
                {
                    NSString *msg = [result objectForKey:@"message"];
                    if ([msg length]==0) {
                        [dataTableView changeProText:YES];
                        [self performSelector:@selector(stopRefreshLoading) withObject:nil afterDelay:0.5];
                    }else
                    {
                        [self stopRefreshLoading];
                    }
                }
            }
        }else
        {
            if (!isMore) {
                [self hideHUDFaild:@"服务器请求失败"];
            }else
            {
                [dataTableView stopRefresh];
                isLoading = NO;
                [self subViewEnabled:YES];
            }
        }

    }];
    
    
}
#pragma mark - 处理列表返回的结果
-(void)dealUrgentInfo:(id)result
{
    NSArray *dataAr= [result objectForKey:@"data"];
    if ([dataAr count]>0) {
//        urgentDic = [dataAr firstObject];
    }
    [dataTableView reloadData];
}
#pragma mark- 批量处理请求服务器
-(void)batchDealWithPosition:(NSArray*)idsArray Status:(int)status
{
    [self showHUD:@"正在处理数据"];
    NSString *idsString = [CombiningData getIdsByArray:idsArray];
    NSString *infoJson = [CombiningData positionManager:idsString Status:status];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self batchDataPrompt:result Success:YES];
                [self performSelector:@selector(afterSecondRequestPosition) withObject:nil afterDelay:1.5];
                
            }else
            {
                [self batchDataPrompt:result Success:NO];
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
        }
    }];

}
#pragma mark - 批量操作的提示
-(void)batchDataPrompt:(id)result Success:(BOOL)isSuccess
{
    NSString *statusString = [result objectForKey:@"requestJson"];
    NSDictionary *dic = [Util dictionaryWithJsonString:statusString];
    int status = [[dic objectForKey:@"new_status"] intValue];
    if (isSuccess) {
        [self rightAction];
        //仍然加载首页
        currentPage1 = 1;
        currentPage2 = 1;
        currentPage3 = 1;
        if (status == 1) {//下线成功
            [self hideHUDWithComplete:@"下线成功"];
        }else if (status == 0)//上线成功
        {
            [self hideHUDWithComplete:@"上线成功"];
        }else if (status == -8)//刷新成功
        {
            [self hideHUDWithComplete:@"刷新成功"];
        }else if (status == -9)//删除成功
        {
            [self hideHUDWithComplete:@"删除成功"];
        }else
        {
            [self hideHUD];
        }
    }else
    {
        if (status == 1) {//下线失败
            [self hideHUDFaild:@"下线失败"];
        }else if (status == 0)//上线失败
        {
            [self hideHUDFaild:@"上线失败"];
        }else if (status == -8)//刷新失败
        {
            [self hideHUDFaild:@"刷新失败"];
        }else if (status == -9)//删除失败
        {
            [self hideHUDFaild:@"删除失败"];
        }else
        {
            [self hideHUD];
        }
        
    }
}
#pragma mark - 延后几秒执行
-(void)afterSecondRequestPosition
{
    [self requestPositionList:NO];
}
@end
