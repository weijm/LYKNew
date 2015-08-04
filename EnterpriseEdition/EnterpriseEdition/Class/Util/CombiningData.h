//
//  CombiningData.h
//  EnterpriseEdition
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CombiningData : NSObject
/**
 组合登录时的json
 */
+(NSString*)loginUser:(NSString*)username Password:(NSString*)password;
+(NSMutableDictionary*)loginUserDic:(NSString*)username Password:(NSString*)password;
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
