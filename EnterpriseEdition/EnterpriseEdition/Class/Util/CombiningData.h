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
@end
