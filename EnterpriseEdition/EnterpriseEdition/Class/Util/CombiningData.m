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
#pragma mark - 登录
//组合登录时的body
+(NSString*)loginUser:(NSString*)username Password:(NSString*)password
{
    NSString *md5Password = [self md5HexDigest:[self md5HexDigest:password]];

    NSString *resultStr = [NSString stringWithFormat:
                           @"{\"token\":\"%@\",\"type\":\"%@\",\"username\":\"%@\",\"password\":\"%@\"}",kToken,kLogin,username,md5Password];
    return resultStr;
}
// 忘记密码时 获取验证码
+(NSString*)forgetPasswordSecurityCode:(NSString*)phone
{
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"mob_no\":\"%@\"}",kToken,kForgetPasswordGetCode,phone];
    return jsonString;
}
//忘记密码时，设置新密码
+(NSString*)forgetSetNewPassword:(NSString*)password Code:(NSString*)code
{
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kAccount];
    NSString *md5Password = [self md5HexDigest:[self md5HexDigest:password]];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"mob_no\":\"%@\",\"new_password\":\"%@\",\"verify\":\"%@\"}",kToken,kForgetSetNewPsw,phone,md5Password,code];
    return jsonString;
}
+(NSString*)changePassword:(NSString*)password NewPsd:(NSString*)newPassword
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefault objectForKey:kUID];
    NSString *md5Passwordold = [self md5HexDigest:[self md5HexDigest:password]];
     NSString *md5PasswordNew = [self md5HexDigest:[self md5HexDigest:newPassword]];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"ent_user_id\":\"%@\",\"password_old\":\"%@\",\"password_new\":\"%@\",\"password_new2\":\"%@\"}",kToken,kChangePsw,uid,md5Passwordold,md5PasswordNew,md5PasswordNew];
    return jsonString;

}
#pragma mark - 注册
+(NSString*)securityCode:(NSString*)phone
{
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"mob_no\":\"%@\"}",kToken,kGetCode,phone];
    return jsonString;
}
//注册
+(NSString*)registerUser:(NSString*)phone Password:(NSString*)password Verify:(NSString*)code
{
    NSString *md5Password = [self md5HexDigest:[self md5HexDigest:password]];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"mob_no\":\"%@\",\"password\":\"%@\",\"verify\":\"%@\"}",kToken,kRegister,phone,md5Password,code];
    return jsonString;
}
#pragma mark - 职位
//提交职位
+(NSString*)addPosition:(NSArray*)contentArray
{
    NSMutableString *subJson = [NSMutableString string] ;
    NSArray *keyArray = [NSArray arrayWithObjects:@"title",@"industry_id",@"job_type_id",@"need_count",@"work_type",[NSArray arrayWithObjects:@"salary_min",@"salary_max", nil],[NSArray arrayWithObjects:@"city_id_1",@"city_id_2",@"city_id_3", nil ],@"address",@"job_description",@"certificate_type",@"work_exp_type",@"department",@"benefit", nil];
    for (int i = 0; i < [contentArray count]; i++) {
        NSObject *contentObj = [contentArray objectAtIndex:i];
        NSObject *keyObj = [keyArray objectAtIndex:i];
        if ([keyObj isKindOfClass:[NSString class]]) {//键是字符串
            NSString *keyString = (NSString*)keyObj;
            NSString *contentString = @"";
            if ([contentObj isKindOfClass:[NSDictionary class]]) {//值的字符串
                NSDictionary *contentDic = (NSDictionary*)contentObj;
                contentString = [contentDic objectForKey:@"content"];
                if ([keyString hasSuffix:@"id"]) {
                    contentString = [contentDic objectForKey:[NSString stringWithFormat:@"%@1",keyString]];
                }

            }
            //拼接字符串
            [subJson appendFormat:@"\"%@\":\"%@\",",keyString,contentString];
        }else if([keyObj isKindOfClass:[NSArray class]])
        {
            NSArray *subKeyArr = (NSArray*)keyObj;
            NSDictionary *contentDic = (NSDictionary*)contentObj;
            for (int j =0; j < [subKeyArr count]; j++) {
                NSString* keyString = [subKeyArr objectAtIndex:j];
                NSString *contentString = [contentDic objectForKey:keyString];
                //拼接字符串
                [subJson appendFormat:@"\"%@\":\"%@\",",keyString,contentString];
            }
       
        }
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *latitude = [NSString stringWithFormat:@"%@",[userDefault objectForKey:kLatitude]];
    NSString *longitude = [NSString stringWithFormat:@"%@",[userDefault objectForKey:kLongitude]];
    NSString *uid = [userDefault objectForKey:kUID];
    NSString *iid = [userDefault objectForKey:KIID];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",%@\"latitude\":\"%@\",\"longitude\":\"%@\",\"uid\":\"%@\",\"iid\":\"%@\"}",kToken,kCommitPosition,subJson,[Util getCorrectString:latitude],[Util getCorrectString:longitude],uid,iid];
    return jsonString;
}
//获取职位列表
+(NSString*)getPositionList:(int)page Status:(int)status
{
    NSString *pageString = [NSString stringWithFormat:@"%d",page];
    NSString *statusString = [NSString stringWithFormat:@"%d",status];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"uid\":\"%@\",\"page\":\"%@\",\"status\":\"%@\"}",kToken,kGetPositionList,KGETOBJ(kUID),pageString,statusString];
    return jsonString;
}
// 职位详情
+(NSString*)getPositionInfo:(int)infoID
{
    NSString *jobIdString = [NSString stringWithFormat:@"%d",infoID];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"uid\":\"%@\",\"jid\":\"%@\"}",kToken,kPositionInfo,KGETOBJ(kUID),jobIdString];
    return jsonString;

}
//职位状态管理
+(NSString*)positionManager:(NSString*)jobIds Status:(int)status
{
    NSString *statusString = [NSString stringWithFormat:@"%d",status];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"job_ids\":\"%@\",\"new_status\":\"%@\"}",kToken,kPositionManagerStatus,jobIds,statusString];
    return jsonString;

    
}
+(NSString*)setPositionUrgent:(NSString*)jobId MaxCount:(int)count
{
    NSString *countString = [NSString stringWithFormat:@"%d",count];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefault objectForKey:kUID];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"ent_job_id\":\"%@\",\"max_count\":\"%@\",\"ent_user_id\":\"%@\"}",kToken,kPositionUrgent,jobId,countString,uid];
    return jsonString;
}
#pragma mark -简历
//获取简历详情
+(NSString*)getResumeInfo:(NSString*)type keyString:(NSString*)key Value:(NSString*)value
{
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"type\":\"%@\",\"token\":\"%@\",\"%@\":\"%@\"}",type,kToken,key,value];
    return jsonString;
}
//上传企业资料
+(NSString*)uploadEntInfo:(NSArray*)contentArray
{
    NSMutableString *subJson = [NSMutableString string] ;
    NSArray *keyArray = [NSArray arrayWithObjects:@"company_name",@"industry_id",@"ent_type",[NSArray arrayWithObjects:@"city_id_1",@"city_id_2",@"city_id_3", nil ],@"address",@"licence_url",@"intro",@"company_size",@"logo_url",@"web_site", nil];
    for (int i = 0; i < [contentArray count]; i++) {
        NSObject *contentObj = [contentArray objectAtIndex:i];
        NSObject *keyObj = [keyArray objectAtIndex:i];
        if ([keyObj isKindOfClass:[NSString class]]) {//键是字符串
            NSString *keyString = (NSString*)keyObj;
            NSString *contentString = @"";
            if ([contentObj isKindOfClass:[NSDictionary class]]) {//值的字符串
                NSDictionary *contentDic = (NSDictionary*)contentObj;
                contentString = [contentDic objectForKey:@"content"];
                if ([keyString hasSuffix:@"id"]) {
                    contentString = [contentDic objectForKey:[NSString stringWithFormat:@"%@1",keyString]];
                }
                
            }
            //拼接字符串
            [subJson appendFormat:@"\"%@\":\"%@\",",keyString,contentString];
        }else if([keyObj isKindOfClass:[NSArray class]])
        {
            NSArray *subKeyArr = (NSArray*)keyObj;
            NSDictionary *contentDic = (NSDictionary*)contentObj;
            for (int j =0; j < [subKeyArr count]; j++) {
                NSString* keyString = [subKeyArr objectAtIndex:j];
                NSString *contentString = [contentDic objectForKey:keyString];
                //拼接字符串
                [subJson appendFormat:@"\"%@\":\"%@\",",keyString,contentString];
            }
            
        }
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
   
    NSString *uid = [userDefault objectForKey:kUID];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",%@\"ent_user_id\":\"%@\"}",kToken,kEntInfoUpload,subJson,uid];
    NSLog(@"jsonString == %@",jsonString);
    return jsonString;

}
//上传企业联系人
+(NSString*)uploadEntContact:(NSArray*)contentArray
{
    NSMutableString *subJson = [NSMutableString string] ;
    NSArray *keyArray = [NSArray arrayWithObjects:@"contact_name",@"contact_no",@"accredit_url", nil];
    for (int i = 0; i < [contentArray count]; i++) {
        NSObject *contentObj = [contentArray objectAtIndex:i];
        NSString *keyString = [keyArray objectAtIndex:i];
        NSString *contentString = @"";
        if ([contentObj isKindOfClass:[NSDictionary class]]) {//值的字符串
            NSDictionary *contentDic = (NSDictionary*)contentObj;
            contentString = [contentDic objectForKey:@"content"];
            
            //拼接字符串
            [subJson appendFormat:@"\"%@\":\"%@\",",keyString,contentString];

       
    }
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *uid = [userDefault objectForKey:kUID];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",%@\"ent_user_id\":\"%@\"}",kToken,kEntContactUpload,subJson,uid];
    NSLog(@"uploadEntContact jsonString == %@",jsonString);
    return jsonString;

    
}

+(NSString*)getMineInfo:(NSString*)type
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefault objectForKey:kUID];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"ent_user_id\":\"%@\"}",kToken,type,uid];
    NSLog(@"jsonString == %@",jsonString);
    return jsonString;
}
+(NSString*)getPicList
{
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\"}",kToken,kPictureList];
    NSLog(@"getPicList jsonString == %@",jsonString);
    return jsonString;
}
+(NSString*)getUIDInfo:(NSString*)type
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefault objectForKey:kUID];
    NSString *jsonString = [NSString stringWithFormat:
                            @"{\"token\":\"%@\",\"type\":\"%@\",\"uid\":\"%@\"}",kToken,type,uid];
    NSLog(@"jsonString == %@",jsonString);
    return jsonString;
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
            NSString *key = [NSString stringWithFormat:@"city_id_%d",i+1];
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
            NSString *key = [NSString stringWithFormat:@"industry_id%d",i];
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
            NSString *key = [NSString stringWithFormat:@"job_type_id%d",i];
            [idsDic setObject:[NSNumber numberWithInt:jobTypeID] forKey:key];
        }
    }
    return idsDic;

}
+(NSString*)getJobType:(int)index
{
    if (index==0) {
        return @"全职";
    }else if (index ==1)
    {
        return @"兼职";
    }else
    {
        return @"实习";
    }
}
+(NSString*)getCertificateType:(int)index
{
    if (index == 0) {
        return @"大专";
    }else if(index == 1)
    {
        return @"本科";
    }else if(index == 2)
    {
        return @"研究生";
    }else
    {
        return @"博士";
    }
}
+(NSString*)getNationStringByID:(int)nationId
{
    NSString *nation = [[PositionObject shareInstance] getNationStringById:nationId];
    return nation;
}
+(NSString*)getEntType:(NSString*)string
{
    NSArray *array = [NSArray arrayWithObjects:@"国有企业", @"有限责任公司",@"股份有限公司",@"中外合资企业",@"私营企业",@"外商投资企业",@"集体企业", nil];
    for (int i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex:i] isEqualToString:string]) {
            return [NSString stringWithFormat:@"%d",i];
        }
    }
    return @"";
}
+(NSString*)getCompanySize:(NSString*)string
{
    NSArray *array = [NSArray arrayWithObjects:@"",@"小于15人",@"15-49人", @"50-149人",@"150-499人",@"500-2000人",@"2000人以上",nil];
    for (int i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex:i] isEqualToString:string]) {
            return [NSString stringWithFormat:@"%d",i];
        }
    }
    return @"";
    
}
+(NSString*)getIdsByArray:(NSArray*)array
{
    NSMutableString *idsString = [NSMutableString string];
    for (int i = 0; i < [array count]; i++) {
        NSString *idString = [array objectAtIndex:i];
        if (i==[array count]-1) {
            [idsString appendString:idString];
        }else
        {
            [idsString appendFormat:@"%@,",idString];
        }
    }
    return idsString;
}
@end
