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


#define kBannerViewHeight 200
#define kHireViewHeight 160
@interface HomePageViewController ()
{
    //横向滚动视图
    BannerView *bannerView;
    
    //应聘部分的视图
    HireView *hireView;
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
    
//    self.view.backgroundColor = Rgb(210, 235, 247, 1.0);
    //初始化item
    [self initItems];

    //初始化bannerView
    [self initBannerView];
    
    //初始化应聘视图
    [self initHireView];
    
    //初始化推荐视图
    [self initCommendView];

    //ios7以上的版本滚动视图自动产生竖向偏移
    if (kDeviceVersion>=7.0 &&[self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = @"aaaa";
    return cell;
}
#pragma mark -bannerView 初始化
-(void)initBannerView
{
    CGRect frame;
    if (kIphone4) {
        frame = CGRectMake(0, 0, kWidth, 150);
    }else
    {
        frame = CGRectMake(0, 0, kWidth, [Util myYOrHeight:kBannerViewHeight]);
    }
    bannerView = [[BannerView alloc] initWithFrame:frame];
    [bannerView loadBannerImage:[NSArray arrayWithObjects:@"11",@"11",@"11", nil]];
    [self.view addSubview:bannerView];
}
#pragma mark - navigation上的左右按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
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
    
}
-(void)rightAction
{
}
#pragma mark - 初始化应聘部分的视图
-(void)initHireView
{
    CGRect frame = CGRectMake(0, bannerView.frame.origin.y+bannerView.frame.size.height, kWidth, [Util myYOrHeight:kHireViewHeight]);
    hireView = [[HireView alloc] initWithFrame:frame];
    [self.view addSubview:hireView];
}
#pragma mark - 初始化推荐部分的视图
- (void)initCommendView
{
    float commendViewY = hireView.frame.origin.y+hireView.frame.size.height;
    float commendViewH = kHeight - commendViewY - [Util myYOrHeight:45];
    //假数据
    NSArray *dataArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"UI设计师",@"job",@"王伟",@"name",@"艺术设计",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"ios开发师",@"job",@"赵倩",@"name",@"计算机专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"java开发",@"job",@"王东志",@"name",@"软件工程",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"web开发",@"job",@"刘一民",@"name",@"数学专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"前段设计",@"job",@"李浩",@"name",@"外语专业",@"pro", nil], nil];
    CommendView *commendView = [[CommendView alloc] initWithFrame:CGRectMake(0, commendViewY, kWidth, commendViewH)];
    [commendView loadSubView:dataArray];
    [self.view addSubview:commendView];
}
@end
