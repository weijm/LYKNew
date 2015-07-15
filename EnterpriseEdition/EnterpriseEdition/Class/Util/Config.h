//
//  Config.h
//  EnterpriseEdition
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#ifndef EnterpriseEdition_Config_h
#define EnterpriseEdition_Config_h
#endif
//设备屏宽
#define kWidth [UIScreen mainScreen].bounds.size.width
//设备高度
#define kHeight [UIScreen mainScreen].bounds.size.height

//各种设备的判断
#define kIphone4  [UIScreen mainScreen].bounds.size.height == 480
#define kIphone5  [UIScreen mainScreen].bounds.size.height == 568
#define kIphone6  [UIScreen mainScreen].bounds.size.height == 667
#define kIphone6plus [UIScreen mainScreen].bounds.size.height == 736
//设备系统版本
#define kDeviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//适配5s 6 6plus的比例
#define autoSizeScaleX kIphone6?1.171875:(kIphone6plus?1.29375:1)
#define autoSizeScaleY kIphone6?1.17429577:(kIphone6plus?1.2957:1)
//导航条高度
#define topBarheight      ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?64:44)

//颜色
#define Rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//导航栏颜色
#define kNavigationBgColor [UIColor colorWithRed:16.0/255.0 green:117/255.0 blue:224/255.0 alpha:1.0]
//简历模块的cell中各视图高度
#define kHeaderViewH [Util myYOrHeight:35]
#define kMiddleViewH [Util myYOrHeight:80]
#define kBottomEachH [Util myYOrHeight:30]
//简历页底部编辑视图高度
#define kFOOTERVIEWH [Util myYOrHeight:45]


#define QMapKey @"OXWBZ-MZHR4-77TUD-DXUNN-R2FPZ-YBB2J"
//导入公共文件
#import "Util.h"