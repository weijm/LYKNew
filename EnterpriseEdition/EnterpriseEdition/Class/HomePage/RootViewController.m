//
//  RootViewController.m
//  首页
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    
 
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
    NSArray *imageArray = [NSArray arrayWithObjects:@"home_icon",@"resume_icon",@"position_icon",@"my_person_icon", nil];
    //生成tabbar的控制器数组
    NSMutableArray *vcArray = [Util generateViewControllerByName:[NSDictionary dictionaryWithObjectsAndKeys:titleArray,@"title",classArray,@"name",imageArray,@"image", nil]];
    
    self.viewControllers = vcArray;
    self.selectedViewController = [vcArray firstObject];
    
    
    //修改tabbar的选中title 的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:                                             kNavigationBgColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    //设置tabbar的选中image的颜色
    self.tabBar.tintColor = kNavigationBgColor;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
