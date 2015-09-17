//
//  JobFairListViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/9/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "JobFairListViewController.h"
#import "JobFairHeaderView.h"
#import "BaseTableView.h"
#import "JobFairListTableViewCell.h"
#import "JobFairInfoViewController.h"

#define kJHeaderViewHeight [Util myYOrHeight:65]

@interface JobFairListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //headerView
    JobFairHeaderView *headerView;
    
    //选择类型
    int  categaryType;
    
    //全部的数组
    NSMutableArray *allArray;
    //我的数组
    NSMutableArray *myArray;
    
    //当前页面
    int  currentPage1;
    int  currentPage2;
    
    BaseTableView *dataTableView;
    
    //拨打热线
    UIWebView *phoneWebView;
}
@end

@implementation JobFairListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"招聘会";
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = kCVBackgroundColor;
    categaryType = 1;
    //初始化headerView
    [self initHeaderView];
    
    //初始化数据列表
    [self initTableView];
    
    allArray = [NSMutableArray array];
    myArray = [NSMutableArray array];
    
    [self getData:categaryType];
    [self getData:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 招聘会列表的headerView
-(void)initHeaderView
{
    if (headerView) {
        [headerView removeFromSuperview];
        headerView = nil;
    }
    headerView = [[JobFairHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kJHeaderViewHeight)];
    __weak JobFairListViewController *wself = self;
    headerView.chooseHeaderBtAction = ^(NSInteger index){
        JobFairListViewController *sself = wself;
        [sself chooseAction:index isChooseAll:NO];
    };
    headerView.makeCallAction = ^(NSString *number){
        JobFairListViewController *sself = wself;
        [sself makeCallToServer:number];
    };
    [headerView changeButtonBgAndTextColor:categaryType-1];
    headerView.backgroundColor = kCVBackgroundColor;
    [self.view addSubview:headerView];
}
#pragma mark - headerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    currentPage1 = 1;
    currentPage2 = 1;
    categaryType = (int)index+1;
    
    [dataTableView reloadData];
}

#pragma mark - 初始化数据列表
-(void)initTableView
{
    float tY = headerView.frame.size.height+headerView.frame.origin.y;
    CGRect frame = CGRectMake(0, tY, kWidth, kHeight-tY-topBarheight);
    dataTableView = [[BaseTableView alloc] initWithFrame:frame];
    dataTableView.separatorColor = [UIColor clearColor];
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    dataTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:dataTableView];
}
#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (categaryType == 1) {
        return [allArray count];
    }else
    {
        return [myArray count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"JobFairListTableViewCellID";
    JobFairListTableViewCell *cell = (JobFairListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[JobFairListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.clickedAction = ^(int index,BOOL isResume){
            [self clickedAction:index Resume:isResume];
        };
    }
    //获取数据
    NSMutableDictionary *dictionary = nil;
    if (categaryType == 1) {
        dictionary = [NSMutableDictionary dictionaryWithDictionary:[allArray objectAtIndex:indexPath.row]];
        cell.isMy = NO;
    }else
    {
        dictionary = [myArray objectAtIndex:indexPath.row];
        cell.isMy = YES;
    }
    
    cell.tag = indexPath.row;
    //加载数据
    [cell loadSubView:dictionary];
    
   
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = nil;
    if (categaryType ==1)
    {
        dic = [allArray objectAtIndex:indexPath.row];
    }else
    {
        dic = [myArray objectAtIndex:indexPath.row];
   
    }
    float cellEdge = [Util myYOrHeight:20];
    float cellHeight = 0;
    float viewW = kWidth-[Util myXOrWidth:10]*2;
    NSString *titStr = [dic objectForKey:@"title"];
    CGSize theStringSize = [titStr sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
    
    cellHeight = theStringSize.height+cellHeight;
    
    float infoW = viewW - [Util myXOrWidth:15] - [Util myXOrWidth:10];
    NSString *content = [NSString stringWithFormat:@"招聘会时间:  %@",[dic objectForKey:@"time"]];
    theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
    cellHeight = theStringSize.height+cellHeight;
    
    content = [NSString stringWithFormat:@"具 体 地 点:  %@",[dic objectForKey:@"address"]];
    theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
    cellHeight = theStringSize.height+cellHeight;
    
    content = [NSString stringWithFormat:@"主 办 单 位:  %@",[dic objectForKey:@"organizer"]];
    theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
    cellHeight = theStringSize.height+cellHeight;
    
    return cellHeight+[Util myYOrHeight:35]+5*5+cellEdge;//内容高度 按钮高度 间隔高度  cell间间隔
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = nil;
    if (categaryType==1) {
        dic = [allArray objectAtIndex:indexPath.row];
    }else
    {
        dic = [myArray objectAtIndex:indexPath.row];
    }
    JobFairInfoViewController *infoVC = [[JobFairInfoViewController alloc] init];
    infoVC.jobFairInfoDic = dic;
    [self.navigationController pushViewController:infoVC animated:YES];
}
#pragma mark - 拨打热线
-(void)makeCallToServer:(NSString*) number
{
    //客服电话
    if ([Util checkDevice:@"iPod"]||[Util checkDevice:@"iPad"]){
        [Util showPrompt:@"该设备不支持打电话的功能"];
        return;
    }
    if (phoneWebView==nil) {
        phoneWebView = [[UIWebView alloc] init];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",number]];
    [phoneWebView loadRequest:[NSURLRequest requestWithURL:url]];

}
#pragma mark - cell上的按钮的触发事件
-(void)clickedAction:(int)index Resume:(BOOL)isResume
{
    if (isResume) {
        NSLog(@"查看简历");
    }else
    {
        NSLog(@"立即报名%d",index);
    }
    
}
#pragma mark - 获取数据
-(void)getData:(int)type
{
   
    for (int i=0; i<5; i++) {
        if (type==1) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"招聘会标招聘会标题招聘会招聘招聘会标招聘会标题招聘会招聘招聘会标招聘会标题招聘会招聘",@"title",@"2015年9月1日-9月5日",@"time",@"北京市石景山古城大街海特花园",@"address",@"可乐易考教育科技有限公司",@"organizer",[NSString stringWithFormat:@"%d",i-1],@"status", nil];
            [allArray addObject:dic];

        }else
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"我参与的招聘会标招聘会标题招聘会招",@"title",@"2015年9月1日-9月5日",@"time",@"北京市石景山古城大街海特花园",@"address",@"可乐易考教育科技有限公司",@"organizer",[NSString stringWithFormat:@"%d",i],@"status", nil];
            [myArray addObject:dic];

        }
        
    }
}


#pragma mark - 字体大小
-(float)getLabFontSize
{
    if (kIphone6||kIphone6plus) {
        return 15;
    }else
    {
        return 14;
    }
}
-(float)getContentFontSize
{
    if (kIphone6||kIphone6plus) {
        return 13;
    }else
    {
        return 12;
    }
}
@end
