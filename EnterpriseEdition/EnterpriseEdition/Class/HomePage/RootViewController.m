//
//  RootViewController.m
//  首页
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()
{
    NSMutableArray *vcArray;
 
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    if (kTestType) {
        [self initVC];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录成功之后初始化的视图
-(void)initVC
{
    //tabbar的title
    NSArray *titleArray = [NSArray arrayWithObjects:@"首页",@"简历",@"职位",@"我的", nil];
    //tabbar的控制器类前缀 如 HomePageViewController这个控制器的名称为HomePage
    NSArray *classArray = [NSArray arrayWithObjects:@"HomePage",@"Resume",@"Position",@"MyInfo", nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"home_icon",@"resume_icon",@"position_icon",@"my_person_icon", nil];
    //生成tabbar的控制器数组
    vcArray = [Util generateViewControllerByName:[NSDictionary dictionaryWithObjectsAndKeys:titleArray,@"title",classArray,@"name",imageArray,@"image", nil]];
    
    self.viewControllers = vcArray;
    self.selectedViewController = [vcArray firstObject];
    
    
    //修改tabbar的选中title 的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:                                             kNavigationBgColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    //设置tabbar的选中image的颜色
    self.tabBar.tintColor = kNavigationBgColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseVC:) name:@"SelectedVC" object:nil];
}
#pragma mark - 消息通知 切换控制器
-(void)chooseVC:(NSNotification*)notification
{
    NSString *object = [notification object];
    int index = [object intValue]/10;
    self.selectedViewController = [vcArray objectAtIndex:index];

}
#pragma mark - LoginViewControllerDelegate;
-(void)loginSuccess
{
    [self initVC];
    
}
@end
