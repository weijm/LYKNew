//
//  AFHttpClient.m
//  AFNetworkingTest
//
//  Created by wjm on 15/5/15.
//  Copyright (c) 2015年 wjm. All rights reserved.
//

#import "AFHttpClient.h"
#import "AFHTTPRequestOperation.h"
//static NSString * const baseURLString = @"http://test3.smartcityos.com/";
//static NSString * const baseURLString = @"https://api.app.net/";
static AFHttpClient *_sharedClient = nil;

@implementation AFHttpClient
/**
 *  单例一个网络请求实体类
 *
 *  @return AFHttpClient
 */
+ (instancetype)sharedClientWithUrlString:(NSString*)urlString
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

+ (instancetype)sharedClient
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] init];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

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
                            completeBlock:(CompleteLoadBlock)block
{
    NSURLSessionDataTask *task = nil;
    __block id result = nil;
    if (httpMethod == HttpMethodPost) {  //如果是post请求
        task = [[self sharedClient] POST:urlString parameters:params success:^(NSURLSessionDataTask *__unused task, id responseObject) {
            if (block) {
                result = [responseObject objectForKey:@"data"];
                block(result);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"AFHttpClient-method:Post;error:%@",error.localizedDescription);
        }];
    } else if (httpMethod == HttpMethodGet) {   //如果是get请求
        task = [[self sharedClient] GET:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            result = [responseObject objectForKey:@"data"];
            block(result);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"AFHttpClient-method:get;error:%@",error.localizedDescription);
        }];
    } else if (httpMethod == HttpMethodPut) {   //如果是put请求
        task = [[self sharedClient] PUT:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            result = [responseObject objectForKey:@"data"];
            block(result);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"AFHttpClient-method:put;error:%@",error.localizedDescription);
        }];
    }
    
    return task;
}

/**
 *  同步请求
 *
 *  @param urlString  请求地址
 *  @param params     参数
 *  @param httpMethod 请求类型
 *  @param _securityPolicy   ssl验证
 *  @return id
 */
+ (id)syncHttpWithURL:(NSString *)urlString params:(NSDictionary *)params httpMethod:(HttpMethod)httpMethod WithSSl:(AFSecurityPolicy*)_securityPolicy
{
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *method = nil;
    if (httpMethod == HttpMethodPost)   method = @"POST";
    if (httpMethod == HttpMethodGet)    method = @"GET";
    if (!method)    return nil;
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:method URLString:urlString parameters:params error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //ssl验证
    if (_securityPolicy != nil) {
        operation.securityPolicy = _securityPolicy;
    }
    //将放回数据转换为json ----start
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setResponseSerializer:responseSerializer];
    //-------end
    [operation start];
    [operation waitUntilFinished];
    
    return [operation responseObject];
}
/**
 *  异步请求
 *
 *  @param urlString  请求地址
 *  @param params     json参数
 *  @param httpMethod 请求类型
 *  @param _securityPolicy   ssl验证
 *  @return id
 */
+ (void)asyncHTTPWithURl:(NSString*)urlString params:(NSString*)params httpMethod:(HttpMethod)httpMethod WithSSl:(AFSecurityPolicy*)_securityPolicy;
{
    NSString *method = nil;
    //确定请求方式
    if(httpMethod == HttpMethodPost) method = @"POST";
    if (httpMethod == HttpMethodGet) method = @"GET";
    if (method == nil) return;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置ssl验证
    if (_securityPolicy != nil) {
        [manager setSecurityPolicy:_securityPolicy];
    }
    //设置请求类型 以json的形式请求
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置请求返回是json的形式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置超时
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",nil];
    
    if ([method isEqualToString:@"POST"]) {
        [manager POST:urlString
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [AFHttpClient sharedClient].FinishedDidBlock(responseObject,nil);
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   [AFHttpClient sharedClient].FinishedDidBlock(nil,error);
              }];
    }else if ([method isEqualToString:@"GET"])
    {
        [manager GET:urlString
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
             }];
    }
    
}

/**
 *  上传文件
 *
 *  @param urlString  请求地址
 *  @param baseUrl    服务器地址
 *  @param fileData   文件流
 *  @param _securityPolicy   ssl验证
 *  @return
 */

+ (void)uploadWithURL:(NSString *)urlString WithBaseUrl:(NSString*)baseUrl attachment:(NSData *)fileData WithSSl:(AFSecurityPolicy*)_securityPolicy
{
    __block BOOL isSuccess = NO;
    BOOL isOpen = (_securityPolicy!=nil)?YES:NO;
    NSString *httpString ;
    if (isOpen) {
        httpString = @"https://";
    }else
    {
        httpString = @"http://";
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",httpString,baseUrl,urlString];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } error:nil];
    [request setHTTPBody:fileData];
    [request setTimeoutInterval:20];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //ssl验证
    if (_securityPolicy != nil) {
        manager.securityPolicy = _securityPolicy;
        
    }
    NSLog(@"is open == %@",(_securityPolicy!=nil)?@"YES":@"NO");
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dic = nil;
        if (!error) {
            NSLog(@"成功返回:%@-----%@", response, responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                dic = responseObject;
                if ([[dic objectForKey:@"status"] intValue]==200) {
                    isSuccess = YES;
                }
            }
        }
        NSLog(@"error == %@",error);
        [AFHttpClient sharedClient].UploadFileStatus(isSuccess,dic);
        
    }];
    
    
    [uploadTask resume];
}
/**
 *  同步请求
 *
 *  @param urlString  请求地址
 *  @param baseUrl    服务器地址
 *  @param _securityPolicy   ssl验证
 *  @return
 */

+ (void)downloadWithUrl:(NSString *)urlString WithBaseUrl:(NSString*)baseUrl WithSSl:(AFSecurityPolicy*)_securityPolicy
{
    BOOL isOpen = (_securityPolicy!=nil)?YES:NO;
    NSString *httpString ;
    if (isOpen) {
        httpString = @"https://";
    }else
    {
        httpString = @"http://";
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",httpString,baseUrl,urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"GET"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //ssl验证
    if (_securityPolicy != nil) {
        manager.securityPolicy = _securityPolicy;
    }
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath,NSURLResponse *response) {
        
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response,NSURL *filePath, NSError *error) {
        NSData *filedata = [NSData dataWithContentsOfURL:filePath];
        [AFHttpClient sharedClient].DownloadFile(filedata);
    }];
    
    [downloadTask resume];
}


@end
