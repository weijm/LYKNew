//
//  AppDelegate.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LoginViewController.h"
#import "NdUncaughtExceptionHandler.h"
#import "ResumeViewController.h"
#import "PositionViewController.h"
#import "UMessage.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //友盟推送
    [self setupUMessage:launchOptions];
    
    //友盟统计
    [self setupUMStatistics];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    
    //设置状态条为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    RootViewController *rootVC = [[RootViewController alloc] init];
    rootVC.loginVC = loginVC;
    loginVC.delegate = rootVC;
    rootVC.delegate = self;
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
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    NSLog(@"deviceToken == %@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
//                  stringByReplacingOccurrencesOfString: @">" withString: @""]
//                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    
    [UMessage registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟对话框
    [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
//    NSLog(@"userInfo == %@",userInfo);
    u_infoDic = userInfo;
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"通知"
                  message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [UMessage sendClickReportForRemoteNotification:u_infoDic];
}
#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController*)viewController;
    NSArray *array = nav.viewControllers;
    if ([array count]>0) {
        UIViewController *vc = (UIViewController *)[array firstObject];
        if ([[[vc class] description] isEqualToString:@"ResumeViewController"]) {
            ResumeViewController *resumeVC = (ResumeViewController *)vc;
            [resumeVC loadStatusFromHomePage:1];

        }else if ([[[vc class] description] isEqualToString:@"PositionViewController"])
        {
            PositionViewController *resumeVC = (PositionViewController *)vc;
            [resumeVC loadStatusFromHomePage:1];
        }
    }
}
#pragma mark - 友盟推送的初始化
-(void)setupUMessage:(NSDictionary *)launchOptions
{
    [UMessage startWithAppkey:@"55ee385467e58e6578003dad" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //日志
//    [UMessage setLogEnabled:YES];
}
-(void)setupUMStatistics
{
    //友盟统计
    [MobClick startWithAppkey:@"55ee385467e58e6578003dad" reportPolicy:BATCH   channelId:@""];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    //日志
//    [MobClick setLogEnabled:YES];
}
@end
