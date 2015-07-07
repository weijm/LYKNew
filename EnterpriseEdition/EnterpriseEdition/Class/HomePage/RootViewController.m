//
//  RootViewController.m
//  首页
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RootViewController.h"
#import "BannerView.h"
#import "HomePageTableViewCell.h"
#import "RegisterUserViewController.h"


#define kBannerViewHeight 200
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //横向滚动视图
    BannerView *bannerView;
    //显示数据的
    UITableView *midTableView;
 
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首页";
    //注册
    UINib *nib = [UINib nibWithNibName:@"HomePageTableViewCell" bundle:nil];
    [midTableView registerNib:nib forCellReuseIdentifier:@"CellId"];
    //初始化item
    [self initItems];
    
    //初始化bannerView
    [self initBannerView];
    
    //初始化下半部分视图
    [self initBottomView];
    
    //ios7以上的版本滚动视图自动产生竖向偏移
    if (kDeviceVersion>=7.0 &&[self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //tableView不滚动
    midTableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navigation上的左右按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"home_setting_btn_n"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
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
    NSLog(@"rightAction");
    RegisterUserViewController *registerVC = [[RegisterUserViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
#pragma mark -bannerView 初始化
-(void)initBannerView
{
    CGRect frame;
    if (kIphone4) {
        frame = CGRectMake(0, topBarheight, kWidth, 150);
    }else
    {
        frame = CGRectMake(0, topBarheight, kWidth, [Util myYOrHeight:kBannerViewHeight]);
    }
    bannerView = [[BannerView alloc] initWithFrame:frame];
    [bannerView loadBannerImage:[NSArray arrayWithObjects:@"",@"",@"", nil]];
    [self.view addSubview:bannerView];
}
#pragma mark - 初始化下半部分视图
-(void)initBottomView
{
    //bottomView的y坐标
    float bHeight = bannerView.frame.origin.y+bannerView.frame.size.height;
    //最下面视图的高度
    float fHeight = [Util myYOrHeight:40];
    //table的frame
    CGRect frame = CGRectMake(0,bHeight , kWidth, kHeight-bHeight-fHeight);
    midTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    midTableView.delegate = self;
    midTableView.dataSource = self;
    [self.view addSubview:midTableView];
    
    //footerView的frame
    frame = CGRectMake(0, kHeight-fHeight, kWidth, fHeight);
    UIView *footerView = [[UIView alloc] initWithFrame:frame];
    footerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:footerView];
    
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellId";
    HomePageTableViewCell *cell = (HomePageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomePageTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.tag = indexPath.row;
        [cell loadEveryCell];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight;
    if (kIphone4) {
        rowHeight = 40;
    }else
    {
        rowHeight = 45;
    }
    if (indexPath.row == 3) {
        float height = tableView.frame.size.height-3*[Util myYOrHeight:rowHeight];
        return height;
    }else
    {
        return [Util myYOrHeight:rowHeight];
    }
}
@end
