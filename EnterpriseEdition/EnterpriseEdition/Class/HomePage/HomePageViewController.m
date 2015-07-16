//
//  HomePageViewController.m
//  app首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HomePageViewController.h"
#import "BannerView.h"
#import "HireView.h"
#import "CommendView.h"
#import "LocationViewController.h"


#define kBannerViewHeight [Util myYOrHeight:200]
#define kHireViewHeight [Util myYOrHeight:160]
@interface HomePageViewController ()
{
    //横向滚动视图
    BannerView *bannerView;
    
    //应聘部分的视图
    HireView *hireView;
    
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
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            return kHeight -150-kHireViewHeight;
        }
        return kHeight -kBannerViewHeight-kHireViewHeight-[Util myYOrHeight:45];
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
    titleLab.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = titleLab;
    
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"home_setting_btn_n"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-20, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
    imageInsets = rightBt.imageEdgeInsets;
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark -- item Action
-(void)leftAction
{
    NSLog(@"leftAction");
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    [self.navigationController pushViewController:locationVC animated:YES];
    
    
}
-(void)rightAction
{
    NSLog(@"rightAvtion");
}
#pragma mark - 初始化应聘部分的视图
-(void)initHireView:(UIView*)view
{
    CGRect frame = CGRectMake(0, 0, kWidth,kHireViewHeight );
    hireView = [[HireView alloc] initWithFrame:frame];
    
    //假数据
    NSArray *array = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"职位 10个",@"string",@"10个",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"急招 剩余12时",@"string",@"剩余12时",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"已下载 100份",@"string",@"100份",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"未处理 100份",@"string",@"100份",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"发布职位",@"string",@"",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"收藏 100份",@"string",@"100份",@"substring", nil], nil];
    
    [hireView loadData:array];
    //点击事件的触发
    __weak HomePageViewController *wSelf = self;
    hireView.clickedHire = ^(NSInteger index){
        HomePageViewController *sSelf = wSelf;
        [sSelf hireAction:index];
    };
    [view addSubview:hireView];
}
#pragma mark - 初始化推荐部分的视图
- (void)initCommendView:(UIView*)view
{
    float commendViewH = kHeight - kBannerViewHeight-kHireViewHeight - [Util myYOrHeight:45];
    if (kIphone4) {
        commendViewH = kHeight - 150-kHireViewHeight ;
    }
    //假数据
    NSArray *dataArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"UI设计师",@"job",@"王伟",@"name",@"艺术设计",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"ios开发师",@"job",@"赵倩",@"name",@"计算机专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"java开发",@"job",@"王东志",@"name",@"软件工程",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"web开发",@"job",@"刘一民",@"name",@"数学专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"前段设计",@"job",@"李浩",@"name",@"外语专业",@"pro", nil], nil];
    
    commendView = [[CommendView alloc] initWithFrame:CGRectMake(0, 0, kWidth, commendViewH)];
    [commendView loadSubView:dataArray];
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
        case 1:
            NSLog(@"职位");
            break;
        case 2:
            NSLog(@"急招");
            break;
        case 3:
            NSLog(@"已下载");
            break;
        case 4:
            NSLog(@"未处理");
            break;
        case 5:
            NSLog(@"发布职位");
            break;
        case 6:
            NSLog(@"收藏");
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
    }else
    {
        NSLog(@"查看第%ld个人的简历",index);
    }
    
}
#pragma mark - 刷新数据
-(void)reloadData
{
    //刷新 应聘部分 hireArray 按照假数据来重新获取
    [hireView loadData:hireArray];
    //刷新推荐部分 commendArray重新获取
    [commendView loadSubView:commendArray];
}

@end
