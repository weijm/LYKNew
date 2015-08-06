//
//  HomePageViewController.m
//  app首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HomePageViewController.h"
#import "BannerView.h"
#import "CommendView.h"
#import "SearchResumeViewController.h"//搜索
#import "NowHiringViewController.h"//急招
#import "CommendResumeViewController.h"//简历推荐
#import "OpenPositionViewController.h" //发布职位
#import "LoginViewController.h"
#import "HireOfView.h"

#import "LocationViewController.h"

#define kBannerViewHeight [Util myYOrHeight:180]
#define kHireViewHeight [Util myYOrHeight:174]
@interface HomePageViewController ()
{
    //横向滚动视图
    BannerView *bannerView;
    
    //应聘部分的视图
    HireOfView *hireOfView;
    //推荐部分的视图
    CommendView *commendView;
    
    //应聘数组
    NSArray *hireArray;

    //推荐数组
    NSArray *commendArray;
}
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首页";
    
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:Rgb(230, 230, 230,0.0)] forBarMetrics:UIBarMetricsDefault];
    //导航栏下面是否显示内容
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.shadowImage = [Util imageWithColor:[UIColor clearColor]];
    
    //初始化item
    [self initItems];

    contentTableView.separatorColor = [UIColor clearColor];

    //ios7以上的版本滚动视图自动产生竖向偏移
    if (kDeviceVersion>=7.0 &&[self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:Rgb(230, 230, 230,0.0)] forBarMetrics:UIBarMetricsDefault];
    //导航栏下面是否显示内容
    [self.navigationController.navigationBar setTranslucent:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            [self initBannerView:cell.contentView];
        }else if (indexPath.row == 1)
        {
            [self initHireView:cell.contentView];
        }else
        {
            [self initCommendView:cell.contentView];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float hireH = kHireViewHeight;
    if (indexPath.row == 0) {
        if(kIphone4)
        {
            return 150;
        }
        return kBannerViewHeight;
    }else if(indexPath.row == 1)
    {
        return kHireViewHeight;
    }else
    {
        if (kIphone4) {
            
            return kHeight -150-hireH+40;
        }else if (kIphone5)
        {
            return kHeight -kBannerViewHeight-hireH;
        }
        return kHeight -kBannerViewHeight-hireH-[Util myYOrHeight:45];
    }
}

#pragma mark -bannerView 初始化
-(void)initBannerView:(UIView*)view
{
    CGRect frame;
    if (kIphone4) {
        frame = CGRectMake(0, 0, kWidth, 150);
    }else
    {
        frame = CGRectMake(0, 0, kWidth, kBannerViewHeight);
    }
    bannerView = [[BannerView alloc] initWithFrame:frame];
    [bannerView loadBannerImage:[NSArray arrayWithObjects:@"11",@"11",@"11", nil]];
    [view addSubview:bannerView];
}
#pragma mark - navigation上的左右按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UILabel *titleLab= [[UILabel alloc] initWithFrame:frame];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"E朝朝企业版";
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont fontWithName:@"Arial-BoldMT" size:17.0];
    
    self.navigationItem.titleView = titleLab;
    
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"home_search_btn"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-20, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark -- item Action
-(void)leftAction
{
    NSLog(@"leftAction");
//    SearchResumeViewController *searchVC = [[SearchResumeViewController alloc] init];
//    searchVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:searchVC animated:YES];
    
    LocationViewController *location = [[LocationViewController alloc] init];
    [self.navigationController pushViewController:location animated:YES];
}
#pragma mark - 初始化应聘部分的视图
-(void)initHireView:(UIView*)view
{
    CGRect frame = CGRectMake(0, 0, kWidth,kHireViewHeight );
//    hireView = [[HireView alloc] initWithFrame:frame];
    hireOfView = [[HireOfView alloc] initWithFrame:frame];
    //假数据
    NSArray *array = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"职位 10个",@"string",@"10个",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"急招 剩余12时",@"string",@"剩余12时",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"已下载 100份",@"string",@"100份",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"已收到 100份",@"string",@"100份",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"发布职位",@"string",@"",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"收藏 100份",@"string",@"100份",@"substring", nil], nil];
    
    [hireOfView loadItem:array];
    //点击事件的触发
    __weak HomePageViewController *wSelf = self;
    hireOfView.clickedHire = ^(int index){
        HomePageViewController *sSelf = wSelf;
        [sSelf hireAction:index];
    };
    [view addSubview:hireOfView];
}
#pragma mark - 初始化推荐部分的视图
- (void)initCommendView:(UIView*)view
{
    float hireH = kHireViewHeight;
    float commendViewH = kHeight - kBannerViewHeight-hireH - [Util myYOrHeight:45];
    if (kIphone4) {
        commendViewH = kHeight - 150-hireH ;
    }
    CGRect frame = CGRectMake(0, 0, kWidth, commendViewH);
    //假数据
    NSArray *dataArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"UI设计师",@"job",@"王伟",@"name",@"艺术设计",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"ios开发师",@"job",@"赵倩",@"name",@"计算机专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"java开发",@"job",@"王东志",@"name",@"软件工程",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"web开发",@"job",@"刘一民",@"name",@"数学专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"前段设计",@"job",@"李浩",@"name",@"外语专业",@"pro", nil], nil];
    
    commendView = [[CommendView alloc] initWithFrame:frame];
    if ([self getEnterpriseCheckState]) {
        [commendView loadSubView:dataArray];
    }else
    {
        [commendView loadSubView:nil];
    }
    
    //点击某个人的触发事件
    
    __weak HomePageViewController *wSelf = self;
    commendView.clickPersonalInfo = ^(NSInteger index){
        HomePageViewController *sself = wSelf;
        [sself lookupPersonalResume:index];
    };
    [view addSubview:commendView];
}

#pragma mark - 点击应聘部分的按钮的相应触发事件
-(void)hireAction:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"职位");
        {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"20"];
        }
            break;
        case 1:
        {
            NSLog(@"急招");
            NowHiringViewController *nowhiringVC = [[NowHiringViewController alloc] init];
            nowhiringVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nowhiringVC animated:YES];

        }
            break;
        case 2:
            NSLog(@"已下载");
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"13"];
        }
            break;
        case 3:
            NSLog(@"已收到");
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"11"];
        }
            break;
        case 4:
            NSLog(@"发布职位");
        {
            OpenPositionViewController *openpVC = [[OpenPositionViewController alloc] init];
            openpVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:openpVC animated:YES];
        }
            break;
        case 5:
            NSLog(@"收藏");
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"12"];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 查看简历
-(void)lookupPersonalResume:(NSInteger) index
{
    if (index == 100) {
        NSLog(@"查看更多推荐简历");
        if (![self getEnterpriseCheckState]) {
            return;
        }
        CommendResumeViewController *commendVC = [[CommendResumeViewController alloc] init];
        commendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:commendVC animated:YES];
    }else
    {
        NSLog(@"查看第%ld个人的简历",(long)index);
    }
    
}
#pragma mark - 刷新数据
-(void)reloadData
{
    //刷新 应聘部分 hireArray 按照假数据来重新获取
    [hireOfView loadItem:hireArray];
    //刷新推荐部分 commendArray重新获取
    [commendView loadSubView:commendArray];
}
#pragma mark - 企业状态
-(BOOL)getEnterpriseCheckState
{
    return YES;
//    return NO;
}
@end
