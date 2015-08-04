//
//  CombiningData.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CombiningData.h"
#import <CommonCrypto/CommonDigest.h>
#import "PositionObject.h"
@implementation CombiningData
//组合登录时的body
+(NSString*)loginUser:(NSString*)username Password:(NSString*)password
{
    NSString *md5Password = [self md5HexDigest:[self md5HexDigest:password]];

    NSString *resultStr = [NSString stringWithFormat:
                           @"{\"token\":\"%@\",\"type\":\"%@\",\"username\":\"%@\",\"password\":\"%@\"}",kToken,kLogin,username,md5Password];
    return resultStr;
}
+(NSMutableDictionary*)loginUserDic:(NSString*)username Password:(NSString*)password
{
    NSString *md5Password = [self md5HexDigest:[self md5HexDigest:password]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:kToken forKey:@"token"];
    [dic setObject:kLogin forKey:@"type"];
    [dic setObject:username forKey:@"username"];
    [dic setObject:md5Password forKey:@"password"];
    return dic;
}
//md5加密
+ (NSString *)md5HexDigest:(NSString *)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    
    return mdfiveString;
}
#pragma mark - 根据内容获取id
// 获取地区对应的ids字典
+(NSMutableDictionary*)getCityIDsByContent:(NSDictionary*)dictionary
{
    NSMutableDictionary * idsDic = [[NSMutableDictionary alloc] init];
    NSArray *values = [dictionary allValues];
    int cityID = 1;
    for (int i =0; i < [values count]; i++) {
        NSString *name = [values objectAtIndex:i];
        int oldId = cityID;
        cityID = [[PositionObject shareInstance] getProvinceOrCityOrAreas:cityID Name:name];
        
        if (cityID >oldId) {
            NSString *key = [NSString stringWithFormat:@"cityID%d",i];
            [idsDic setObject:[NSNumber numberWithInt:cityID] forKey:key];
        }
    }
    return idsDic;
}
// 获取行业对应的ids字典
+(NSMutableDictionary*)getIndustryIDsByContent:(NSDictionary*)dictionary
{
    NSMutableDictionary * idsDic = [[NSMutableDictionary alloc] init];
    NSArray *values = [dictionary allValues];
    int industryID = 0;
    for (int i =0; i < [values count]; i++) {
        NSString *name = [values objectAtIndex:i];
        int oldId = industryID;
        industryID = [[PositionObject shareInstance]getIndustryIds:industryID Name:name];
        if (industryID >oldId) {
            NSString *key = [NSString stringWithFormat:@"IndustryID%d",i];
            [idsDic setObject:[NSNumber numberWithInt:industryID] forKey:key];
        }
    }
    return idsDic;
}
// 获取职位名称对应的ids字典
+(NSMutableDictionary*)getJobTypeIDsByContent:(NSDictionary*)dictionary
{
    NSMutableDictionary * idsDic = [[NSMutableDictionary alloc] init];
    NSArray *values = [dictionary allValues];
    int jobTypeID = 0;
    for (int i =0; i < [values count]; i++) {
        NSString *name = [values objectAtIndex:i];
        int oldId = jobTypeID;
        jobTypeID = [[PositionObject shareInstance] getJobTypeIds:jobTypeID Name:name];
        if (jobTypeID >oldId) {
            NSString *key = [NSString stringWithFormat:@"JobTypeID%d",i];
            [idsDic setObject:[NSNumber numberWithInt:jobTypeID] forKey:key];
        }
    }
    return idsDic;

}
@end
