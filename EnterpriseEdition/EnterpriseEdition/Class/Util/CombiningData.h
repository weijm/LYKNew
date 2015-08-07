//
//  CombiningData.h
//  EnterpriseEdition
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CombiningData : NSObject
#pragma mark - 请求时的json
#pragma mark - 登录
/**
 组合登录时的json
 */
+(NSString*)loginUser:(NSString*)username Password:(NSString*)password;
#pragma mark - 注册
/**
 获取验证码
 */
+(NSString*)securityCode:(NSString*)phone;
/**
 注册
 */
+(NSString*)registerUser:(NSString*)phone Password:(NSString*)password Verify:(NSString*)code;
#pragma mark - 职位
/**
 提交职位
 */
+(NSString*)addPosition:(NSArray*)contentArray;
/**
 获取职位列表
 */
+(NSString*)getPositionList:(int)page Status:(int)status;
#pragma mark - 从本地数据库中转换id
/**
 获取地区对应的ids字典
 */
+(NSMutableDictionary*)getCityIDsByContent:(NSDictionary*)dictionary;
/**
 获取行业对应的ids字典
 */
+(NSMutableDictionary*)getIndustryIDsByContent:(NSDictionary*)dictionary;
/**
 获取职位名称对应的ids字典
 */
+(NSMutableDictionary*)getJobTypeIDsByContent:(NSDictionary*)dictionary;
@end
