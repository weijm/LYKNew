//
//  WebInterface.h
//  请求接口
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#ifndef EnterpriseEdition_WebInterface_h
#define EnterpriseEdition_WebInterface_h
#endif
//登录的token码
#define kToken @"0a20ece95e098dd38621410f5a3f8dda"
//服务器地址
#define kWEB_BASE_URL @"http://ezz.teiit.com:88/interface_ent/"
#pragma mark - 登录
//登录接口
#define kLogin @"ent_login"

#pragma mark- 注册
//获取验证码
#define kGetCode @"ent_reg_verify"
//注册
#define kRegister @"ent_reg_info"

#pragma mark - 职位
//提交审核职位
#define kCommitPosition @"ent_job_add"
//获取职位列表
#define kGetPositionList @"ent_job_list"