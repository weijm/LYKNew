//
//  RootViewController.m
//  首页
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "ResumeViewController.h"
#import "PositionViewController.h"

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
    [self initVC];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:kLoginOut object:nil];
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
    int selectedIndex = [object intValue];
    int index = selectedIndex/10;
    self.selectedViewController = [vcArray objectAtIndex:index];
    UINavigationController *nav = [vcArray objectAtIndex:index];
    int selectedStatus = selectedIndex%10;
    if (index==1) {//简历管理
        NSArray *array = nav.viewControllers;
        if ([array count]>0) {
            ResumeViewController *resumeVC = (ResumeViewController *)[array firstObject];
            [resumeVC loadStatusFromHomePage:selectedStatus];
            
        }
    }else if (index ==2)//职位管理
    {
        NSArray *array = nav.viewControllers;
        if ([array count]>0) {
            PositionViewController *positionVC = (PositionViewController *)[array firstObject];
            [positionVC loadStatusFromHomePage:selectedStatus];
            
        }
        
    }
    

}
#pragma mark - LoginViewControllerDelegate;
-(void)loginSuccess
{
//    [self initVC];
    self.selectedViewController = [vcArray firstObject];
    //定位
//    [[LocationViewController shareInstance] loadLocation];
    
       

}
-(void)loginOut:(NSNotification *)notification
{
    NSString *loginOrExit = [notification object];
    if([loginOrExit intValue]==1)
    {
        //登录页面
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:_loginVC];
        //导航条的背景颜色
        [navigation.navigationBar setBarTintColor:kNavigationBgColor];
        // 设置navigation的title颜色
        NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
        [navigation.navigationBar setTitleTextAttributes:textAttrs];
        [self presentViewController:navigation animated:YES completion:nil];
    }else
    {
        [_loginVC dismissViewControllerAnimated:YES completion:nil];
        self.selectedViewController = [vcArray firstObject];
    }
}

@end
