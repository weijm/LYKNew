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
/**
 修改密码
 */
+(NSString*)changePassword:(NSString*)password NewPsd:(NSString*)newPassword;
/**
 验证码验证
 */
+(NSString*)checkCode:(NSString*)code Mobile:(NSString*)phone;
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
 提交职位 保存 编辑职位信息
 */
+(NSString*)addPosition:(NSArray*)contentArray Type:(NSString*)type PositionId:(NSString*)jobId ActionType:(NSString*)actionType;
/**
 获取职位列表
 */
+(NSString*)getPositionList:(int)page Status:(int)status;
/**
 职位详情
 */
+(NSString*)getPositionInfo:(int)infoID;
/**
 职位状态管理
 */
+(NSString*)positionManager:(NSString*)jobIds Status:(int)status;
/**
 设置急招
 */
+(NSString*)setPositionUrgent:(NSString*)jobId MaxCount:(int)count;
/**
 查看职位对应的简历
 */
+(NSString*)getResumeListFromPosiotion:(NSString*)jobId PageIndex:(int)page IsUrgent:(NSString*)urgent;
#pragma mark - 简历
/**
 点击查看简历联系方式
 */
+(NSString*)getLookContact:(NSString*)jobID ResumeId:(NSString*)resumeID;
/**
 简历列表
 */
+(NSString*)getResumeList:(int)page Status:(int)status;

/**
 筛选简历
 */
+(NSString*)searchResumeInManager:(NSArray*)contentArray PageIndex:(int)page;
/**
 批量管理简历
 */
+(NSString*)batchManagerResume:(NSString*)idsString Status:(int)type;
/**
 获取简历详情
 */
+(NSString*)getResumeInfo:(NSString*)type keyString:(NSString*)key Value:(NSString*)value;
#pragma mark - 企业资料
/**
 上传企业资料
 */
+(NSString*)uploadEntInfo:(NSArray*)contentArray;
/**
 上传企业联系人
 */
+(NSString*)uploadEntContact:(NSArray*)contentArray;

/**
 企业id的json
 */
+(NSString*)getMineInfo:(NSString*)type;
/**
 获取首页图片
 */
+(NSString*)getPicList;
/**
 获取首页数据
 */
+(NSString*)getUIDInfo:(NSString*)type;
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
 获取专业名称对应的ids字典
 */
+(NSMutableDictionary*)getMajorIDsByContent:(NSDictionary*)dictionary;
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
/**
 获取企业性质id
 */
+(NSString*)getEntType:(NSString*)string;
/**
 获取人数规模id
 */
+(NSString*)getCompanySize:(NSString*)string;
/**
 获取职位类型id
 */
+(NSString*)getJObTypeId:(NSString*)string;
/**
 获取职位类型id
 */
+(NSString*)getCerId:(NSString*)string;
/**
 获取职位类型id
 */
+(NSString*)getExpId:(NSString*)string;
/**
 拼写ids
 */
+(NSString*)getIdsByArray:(NSArray*)array;
@end
