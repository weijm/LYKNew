//
//  CombiningData.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CombiningData.h"
#import <CommonCrypto/CommonDigest.h>
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

@end
