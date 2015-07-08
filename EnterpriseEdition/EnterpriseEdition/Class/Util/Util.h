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
+(CGFloat)randomRate;
@end
