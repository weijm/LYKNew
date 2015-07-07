//
//  Util.h
//  公共方法类
//
//  Created wjm  on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end
