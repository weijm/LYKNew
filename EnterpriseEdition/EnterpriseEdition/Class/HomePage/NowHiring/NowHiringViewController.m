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
#import "ResumeInfoViewController.h"
#define kNHeaderViewHeight [Util myYOrHeight:85]

@interface NowHiringViewController ()
{
    NSMutableArray *chooseArray;
    
    UIButton_Custom *rightBt;
    
    FooterView *footerView;
    
    NowHiringHeaderView *headerView;
    BOOL isLoading;
    int currentPage;
    
    int isFirst;
}
@end

@implementation NowHiringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    self.title = @"急招";
    currentPage = 1;
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    //初始化headerView
    [self initHeaderView];
    
    //设置tableView
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorColor = [UIColor clearColor];
    
    //初始化items
//    [self initItems];

    
    categaryType = 1;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    if (isFirst==0) {
        [self requestResumeListFromPosition:NO];
        isFirst = 1;
    }
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
        cell.urgentJobName = [Util getCorrectString:[_urgentDic objectForKey:@"job_type"]];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResumeInfoViewController *infoVC = [[ResumeInfoViewController alloc] init];
    NSDictionary *dic = nil;
    if (categaryType == 1) {
        dic = [receivedArray objectAtIndex:indexPath.row];
        infoVC.resumeID = [dic objectForKey:@"stu_resume_id"] ;
        infoVC.jobID = [_urgentDic objectForKey:@"id"];
    }else
    {
        dic = [commendArray objectAtIndex:indexPath.row];
        infoVC.resumeID = [dic objectForKey:@"id"] ;
        infoVC.jobID = @"0";

    }
     infoVC.internships = [[dic objectForKey:@"internships"] intValue];
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
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
    headerView.urgDic = [NSDictionary dictionaryWithDictionary:_urgentDic] ;
    [headerView initProgressView];
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
#pragma mark - 编辑按钮
//-(void)initItems
//{
//    CGRect frame = CGRectMake(0, 0, 50, 30);
//    
//    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
//    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
//    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
//    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-30, imageInsets.bottom, imageInsets.right+20);
//    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//    rightBt = [[UIButton_Custom alloc] initWithFrame:frame];
//    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
//    imageInsets = rightBt.imageEdgeInsets;
//    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
//    rightBt.titleLabel.font = [UIFont systemFontOfSize:14];
//    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
//    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+20, titleInsets.bottom, titleInsets.right-20);
//    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//    
//}
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
        if (index ==0) {
            currentPage = 1;
            [self requestResumeListFromPosition:NO];
        }else if (index == 1)
        {
            [self requestInfoFromWeb];
        }
        categaryType = (int)index+1;
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
                break;
            case 30:
                break;
            case 200:
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
-(void)requestResumeListFromPosition:(BOOL)isMore
{
    
    int page = currentPage;
    NSString *jsonString = nil;
    if (!isMore) {
        [self showHUD:@"正在加载数据"];
    }
    jsonString = [CombiningData getResumeListFromPosiotion:[_urgentDic objectForKey:@"id"]  PageIndex:page IsUrgent:@"1"];
    
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
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
                if ([message length]==0) {
                    message = @"数据为空";
                }
                if (!isMore) {
                    [self hideHUDFaild:message];
                }else
                {
                    NSString *msg = [result objectForKey:@"message"];
                    if ([msg isEqualToString:@"已经到最后一页"]) {
                        [dataTableView changeProText:YES];
                        [self performSelector:@selector(stopRefreshLoading) withObject:nil afterDelay:0.25];
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
//停止刷新
-(void)stopRefreshLoading
{
    [dataTableView stopRefresh];
    isLoading = NO;
    [self subViewEnabled:YES];
    [dataTableView changeProText:NO];
}
-(void)dealWithResponeData:(NSArray*)array
{
    if (currentPage>1) {
        [receivedArray addObjectsFromArray:array];
    }else
    {
        receivedArray = [NSMutableArray arrayWithArray:array];
    }
    currentPage++;
    [dataTableView reloadData];

}
#pragma mark - 加载数据中 不可以点击本页的事件
-(void)subViewEnabled:(BOOL)enable
{
    self.navigationItem.rightBarButtonItem.enabled = enable;
    self.navigationItem.leftBarButtonItem.enabled = enable;
    headerView.userInteractionEnabled = enable;
}
//刷新加载更多
-(void)refreshData
{
    if (rightBt.specialMark == 0) {//不处于编辑状态 可以加载更多
        isLoading = YES;
        //请求数据
        [self requestResumeListFromPosition:YES];
        //本页其他事件不可触发
        [self subViewEnabled:NO];
    }else
    {
        [dataTableView stopRefresh];
    }
}
#pragma mark - 从服务器获取信息
-(void)requestInfoFromWeb
{
    NSString *jsonString = [CombiningData getUIDInfo:kCommendList];
    [self showHUD:@"正在加载数据"];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                commendArray = [NSMutableArray arrayWithArray:[result objectForKey:@"data"]];
                [dataTableView reloadData];
                
            }else
            {
                if ([[result objectForKey:@"message"] isEqualToString:@"已经到最后一页"]) {
                    [self hideHUD];
                }else
                {
                    [self hideHUDFaild:[result objectForKey:@"message"]];
                }
                
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
            //                [self showAlertView:@"服务器请求失败"];
        }
    }];

}

@end
