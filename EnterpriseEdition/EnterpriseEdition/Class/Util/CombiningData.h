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
/**
 忘记密码时 获取验证码
 */
+(NSString*)forgetPasswordSecurityCode:(NSString*)phone;
/**
 忘记密码时，设置新密码
 */
+(NSString*)forgetSetNewPassword:(NSString*)password Code:(NSString*)code;
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
/**
 职位详情
 */
+(NSString*)getPositionInfo:(int)infoID;
#pragma mark - 简历
/**
 获取简历详情
 */
+(NSString*)getResumeInfo:(NSString*)type keyString:(NSString*)key Value:(NSString*)value;
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
/**
 根据数字获取职位类型
 */
+(NSString*)getJobType:(int)index;
/**
 根据数字获取学历
 */
+(NSString*)getCertificateType:(int)index;
/**
 根据民族id获取民族
 */
+(NSString*)getNationStringByID:(int)nationId;

@end
