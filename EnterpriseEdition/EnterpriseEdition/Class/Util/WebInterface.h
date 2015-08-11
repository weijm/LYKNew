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
//忘记密码
#define kForgetPasswordGetCode @"ent_forget_verify"
//忘记密码时 设置新密码
#define kForgetSetNewPsw @"ent_forget_newpassword"
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
//职位详情
#define kPositionInfo @"ent_job_detail"

#pragma mark - 简历
#pragma mark - 简历列表
//简历管理里面的简历列表
#define kResumeList @""

#pragma mark - 简历详情
//简历的个人信息
#define kResumeBaseInfo @"stu_resume_user_info_view"
//简历求职意向
#define kResumeJobObjective @"stu_resume_job_objective_view"
//简历详情教育背景列表
#define kResumeDegreeList @"stu_resume_degree_list"
//简历 兴趣
#define kResumeInterest @"stu_resume_interest_view"
//简历 实习经验
#define kResumeInternships @"stu_resume_internships_list"
//简历在校职务
#define kResumePositionInSchool @"stu_resume_position_view"
//简历自我评价
#define kResumeAppraisal @"stu_resume_self_appraisal_view"
//简历个人荣誉
#define kResumeReward @"stu_resume_reward_view"
//简历 求职证书
#define kResumeCertify @"stu_resume_certify_list"
