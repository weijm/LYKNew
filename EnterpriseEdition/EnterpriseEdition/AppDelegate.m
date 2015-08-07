//
//  AppDelegate.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <QMapKit/QMapKit.h>
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //设置状态条为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //定位功能
    [QMapServices sharedServices].apiKey = @"OXWBZ-MZHR4-77TUD-DXUNN-R2FPZ-YBB2J";
//    CLLocationManager* locationManager = [[CLLocationManager alloc] init];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
//        [locationManager requestWhenInUseAuthorization];
//    }

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    RootViewController *rootVC = [[RootViewController alloc] init];
    rootVC.loginVC = loginVC;
    loginVC.delegate = rootVC;
    self.window.rootViewController = rootVC;
    //登录页面
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    //导航条的背景颜色
    [navigation.navigationBar setBarTintColor:kNavigationBgColor];
    // 设置navigation的title颜色
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
    [navigation.navigationBar setTitleTextAttributes:textAttrs];
    NSString *loginOrExit = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginOrExit];
    if ([loginOrExit integerValue]!= 1) {
        [rootVC presentViewController:navigation animated:YES completion:nil];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
