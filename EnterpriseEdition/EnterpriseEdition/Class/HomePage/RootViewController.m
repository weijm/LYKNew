//
//  RootViewController.m
//  首页
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RootViewController.h"

#import "HomePageTableViewCell.h"
#import "RegisterUserViewController.h"



@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    //显示数据的
    UITableView *midTableView;
 
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //tabbar的title
    NSArray *titleArray = [NSArray arrayWithObjects:@"首页",@"简历",@"职位",@"我的", nil];
    //tabbar的控制器类前缀 如 HomePageViewController这个控制器的名称为HomePage
    NSArray *classArray = [NSArray arrayWithObjects:@"HomePage",@"Resume",@"Position",@"MyInfo", nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"home_icon",@"resume_icon",@"position_icon",@"my_icon", nil];
    //生成tabbar的控制器数组
    NSMutableArray *vcArray = [Util generateViewControllerByName:[NSDictionary dictionaryWithObjectsAndKeys:titleArray,@"title",classArray,@"name",imageArray,@"image", nil]];
    
    self.viewControllers = vcArray;
    self.selectedViewController = [vcArray firstObject];
    
    
    //修改tabbar的选中title 的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:                                             kNavigationBgColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    //设置tabbar的选中image的颜色
    self.tabBar.tintColor = kNavigationBgColor;

//    self.title = @"首页";
//    //注册
//    UINib *nib = [UINib nibWithNibName:@"HomePageTableViewCell" bundle:nil];
//    [midTableView registerNib:nib forCellReuseIdentifier:@"CellId"];
//
//    
//    
//    //初始化下半部分视图
//    [self initBottomView];
//    
//    
//    //tableView不滚动
//    midTableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//#pragma mark - 初始化下半部分视图
//-(void)initBottomView
//{
//    //bottomView的y坐标
//    float bHeight = bannerView.frame.origin.y+bannerView.frame.size.height;
//    //最下面视图的高度
//    float fHeight = [Util myYOrHeight:40];
//    //table的frame
//    CGRect frame = CGRectMake(0,bHeight , kWidth, kHeight-bHeight-fHeight);
//    midTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
//    midTableView.delegate = self;
//    midTableView.dataSource = self;
//    [self.view addSubview:midTableView];
//    
//    //footerView的frame
//    frame = CGRectMake(0, kHeight-fHeight, kWidth, fHeight);
//    UIView *footerView = [[UIView alloc] initWithFrame:frame];
//    footerView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:footerView];
//    
//}
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
