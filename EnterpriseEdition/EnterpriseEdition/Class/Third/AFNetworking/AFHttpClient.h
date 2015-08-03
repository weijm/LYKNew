//
//  AFHttpClient.h
//  AFNetworkingTest
//
//  Created by wjm on 15/5/15.
//  Copyright (c) 2015年 wjm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

#define CONTENTTYPEJSON @"application/json"

typedef void(^CompleteLoadBlock) (id result);

typedef enum : NSUInteger {
    HttpMethodPost,         //http post 请求
    HttpMethodGet,          //http get 请求
    HttpMethodPut,          //http put 请求
} HttpMethod;

@interface AFHttpClient : AFHTTPSessionManager
//上传头像回调
@property(nonatomic,copy)void(^UploadFileStatus)(BOOL isSuccess ,NSDictionary *dictionary);
//下载文件获取字节流
@property(nonatomic,copy)void(^DownloadFile)(NSData *data);
//异步请求 返回的结果
@property (nonatomic,copy) void(^FinishedDidBlock)(id result,NSError *error);
+ (instancetype)sharedClientWithUrlString:(NSString*)urlString;
+ (instancetype)sharedClient;

/**
 *  http请求的基类
 *
 *  @param urlString  请求地址
 *  @param params     参数
 *  @param httpMethod 请求类型
 *  @param block      成功后执行的block
 *
 *  @return 返回一个task (暂时没用到）
 */
+ (NSURLSessionDataTask *)taskHttpWithURL:(NSString *)urlString
                                   params:(NSMutableDictionary *)params
                               httpMethod:(HttpMethod)httpMethod
                            completeBlock:(CompleteLoadBlock)block;

/**
 *  同步请求
 *
 *  @param urlString  请求地址
 *  @param params     参数
 *  @param httpMethod 请求类型
 *
 *  @return id
 */
+ (id)syncHttpWithURL:(NSString *)urlString params:(NSDictionary *)params httpMethod:(HttpMethod)httpMethod WithSSl:(AFSecurityPolicy*)_securityPolicy;
/**
 *  同步请求
 *
 *  @param urlString  请求地址
 *  @param params     json参数
 *  @param httpMethod 请求类型
 *  @param _securityPolicy ssl请求文件
 *  @return id
 */
+ (void)asyncHTTPWithURl:(NSString*)urlString params:(NSString*)params httpMethod:(HttpMethod)httpMethod WithSSl:(AFSecurityPolicy*)_securityPolicy;
//+ (id)uploadWithURL:(NSString *)urlString attachment:(NSData *)fileData;
+ (void)uploadWithURL:(NSString *)urlString WithBaseUrl:(NSString*)baseUrl attachment:(NSData *)fileData WithSSl:(AFSecurityPolicy*)_securityPolicy;
//下载文件
+ (void)downloadWithUrl:(NSString *)urlString WithBaseUrl:(NSString*)baseUrl WithSSl:(AFSecurityPolicy*)_securityPolicy;
@end

