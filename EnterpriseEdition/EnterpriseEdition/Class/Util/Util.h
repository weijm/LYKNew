//
//  Util.h
//  公共方法类
//
//  Created wjm  on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject
/**
 获取不同设备字体的大小
 */
+(float)myFontSize:(float)fontSize;
/**
 获取不同设备视图的宽度
 */
+(float)myXOrWidth:(float)xOrWidth;
/**
 获取不同设备的视图高度
 */
+(float)myYOrHeight:(float)yOrHeight;
/**
 正则表达式 手机号码验证
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 根据数组中的类名称，title，image 生成tabbar的Viewcontrollers
 */
+(NSMutableArray*)generateViewControllerByName:(NSDictionary*)classInfoDic;
/**
 获取bundle下文件的路径
 */
+(NSString*)getBundlePath:(NSString*)fileName;
/**
 根据颜色获取对应色值的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 随机生成颜色
 */
+(UIColor *) randomColor;
/**
 随机生成匹配度
 */
+(NSInteger)randomRate;
/**
 根据总数和每行显示的个数计算行数
 */
+(int)getRow:(int)total eachCount:(int)count;

#pragma mark - 判断字符串是否符合要求

/**
 验证码密码
 */
+(BOOL)checkPassWord:(NSString *)passWord;
/**
 检查手机号码
 */
+ (BOOL)checkTelephone:(NSString *)phone;
/**
 提示信息
 */
+(void)showPrompt:(NSString*)promptString;
#pragma mark - 文件路径
/**
 获取document的路径
 */
+(NSString*)documentPath;
/**
 复制原文件到指定目录
 */
+(BOOL)copyFile:(NSString*)originalPath To:(NSString*)targetPath;

/**
 用户的数据库文件路径
 */
+(NSString*)getSQLitePath;

@end
