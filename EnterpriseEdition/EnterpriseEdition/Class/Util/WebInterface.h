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
//开发服务器地址
//#define kWEB_BASE_URL @"http://ezz.teiit.com/interface_ent/"
//测试服务器地址
//#define kWEB_BASE_URL @"http://192.168.2.226/interface_ent/"
//线上
#define kWEB_BASE_URL @"http://interface.ezz2.1zhaozhao.com/interface_ent/"
#pragma mark - 登录
//登录接口
#define kLogin @"ent_login"
//忘记密码
#define kForgetPasswordGetCode @"ent_forget_verify"
//忘记密码时 设置新密码
#define kForgetSetNewPsw @"ent_forget_newpassword"
//验证验证码
#define kCodeCheck @"ent_reg_check"

//修改密码
#define kChangePsw @"ent_my_password_edit"
#pragma mark- 注册
//获取验证码
#define kGetCode @"ent_reg_verify"
//注册
#define kRegister @"ent_reg_info"


#pragma mark - 职位
//保存职位信息
#define kSavePositionInfo @"ent_job_save"
//编辑职位信息
#define kEditPositionInfo @"ent_job_edit"
//提交审核职位
#define kCommitPosition @"ent_job_add"
//获取职位列表
#define kGetPositionList @"ent_job_list"
//职位详情
#define kPositionInfo @"ent_job_detail"
//职位管理-修改状态
#define kPositionManagerStatus @"ent_job_status"
//设置急招
#define kPositionUrgent @"ent_job_emergent_status"
//查看职位对应的简历
#define kResumeFromPosition @"ent_job_resume_list"

//获取急招职位信息
#define kGetUrgentInfo @"ent_job_emergent_view"

#pragma mark - 简历
#pragma mark - 简历列表
//简历点击查看联系方式
#define kResumeTapLookContact @"ent_resume_download"
//简历管理里面的简历列表
#define kResumeList @"ent_resume_list"
//筛选简历
#define kSearchResume @"ent_resume_search_list"
//批量操作简历
#define kBatchDealResume @"ent_resume_favorites"
//招聘会收到的简历
#define kResumeFromFair @"ent_fair_resume_list"

#pragma mark - 简历详情
//简历详情剩余次数
#define kResumeDownloadCount @"ent_download_count"
//简历状态
#define kResumeStatus @"stu_resume_status"
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

#pragma mark 企业资料
//上传企业资料
#define kEntInfoUpload @"ent_my_info_save"
//读取企业信息
#define kGetEntInfo @"ent_my_info_view"
//上传企业联系人
#define kEntContactUpload @"ent_my_contactperson_save"
//获取企业联系人
#define kGetEntContactInfo @"ent_my_contactperson_view"
//获取我的首页的信息
#define kMineInfo @"ent_my_statistics"

#pragma mark - 首页
//获取首页banner的图片
#define kPictureList @"ent_index_picture_list"
//数据的获取
#define kNumberList @"ent_index_statistics"
//简历推荐
#define kCommendList @"ent_index_recommend_list"

#pragma mark - 招聘会
//招聘会列表
#define kJobFairList @"ent_fair_list"
//招聘会详情
#define kJobFairInfo @"ent_fair_view"
//招聘会报名
#define kJobFairApply @"ent_fair_apply"
//招聘会签到
#define kQRCodeSign @"ent_fair_qrcode_checkin"
//扫描简历二维码第一步
#define kQRCodeResumeStep1 @"ent_fair_qrcode_resume_step1"
//扫描简历二维码第二步
#define kQRCodeResumeStep2 @"ent_fair_qrcode_resume_step2"

//上传图片 
//#define kUploadImg [NSString stringWithFormat:@"http://42.62.92.59/interface_ent/upload_file_0a20ece95e098dd38621410f5a3f8dda.php"]
//线上
#define kUploadImg [NSString stringWithFormat:@"http://interface.ezz2.1zhaozhao.com/upload_file_0a20ece95e098dd38621410f5a3f8dda.php"]


#pragma mark - 信息
//消息列表
#define kMsgList @"ent_message_list"
//消息详情
#define kMsgInfo @"ent_message_view"
//批量设置已读和删除
#define kMsgSet @"ent_message_set"
//获取消息的未读数量
#define kMsgUnReadCount @"ent_message_new"
