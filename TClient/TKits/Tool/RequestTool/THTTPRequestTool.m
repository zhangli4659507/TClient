//
//  THTTPRequestTool.m
//  TClient
//
//  Created by Mark on 2018/9/4.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "THTTPRequestTool.h"
#import "AFNetworking.h"
static NSString *const BaseUrl = @"http://47.104.239.171";
NSInteger const TRequestSuccessCode = 200;
NSInteger const TRequestUnauthorizedCode = 401;
NSInteger const TRequestParNullCode = 40001;
NSInteger const TRequestNotFindResultCode = 40004;
NSInteger const TRequestServerUnusualCode = 0;
NSInteger const TRequestNetConnectFailedCode = 500;
@implementation THTTPRequestTool
+(void)getRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic finishBlock:(void(^)(TResponse *response))finshBlock {
    AFHTTPSessionManager *manger = [self netSessionManger];
    [manger GET:url parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     [self requestResponse:responseObject task:task finishBlock:finshBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestResponse:nil task:task finishBlock:finshBlock];
        
    }];
    
}

+(void)postRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic finishBlock:(void(^)(TResponse *response))finshBlock {
    AFHTTPSessionManager *manger = [self netSessionManger];
    [manger POST:url parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestResponse:responseObject task:task finishBlock:finshBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestResponse:nil task:task finishBlock:finshBlock];
    }];
    
}

+ (void)requestResponse:(id)response task:(NSURLSessionDataTask *)task finishBlock:(void(^)(TResponse *response))finshBlock {
    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
    if (response == nil) {
        TResponse *responseObj = [[TResponse alloc] init];
        responseObj.code = TRequestNetConnectFailedCode;
        responseObj.msg = [NSString stringWithFormat:@"加载失败，请重试！(-%ld)",TRequestNetConnectFailedCode];
        !finshBlock?:finshBlock(responseObj);
        return;
    }
    
    if (response && urlResponse.statusCode >=200 && urlResponse.statusCode <=299 ) {
        TResponse *responseObj = [[TResponse alloc] init];
        responseObj.msg = response[@"msg"];
        responseObj.data = response[@"data"];
        responseObj.code = [response[@"code"] integerValue];
        !finshBlock?:finshBlock(responseObj);
    }
   
}


+ (AFHTTPSessionManager *)netSessionManger  {
    
    static AFHTTPSessionManager *manger;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       manger = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
       manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
    });
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"hehe" forHTTPHeaderField:@"test"];
    manger.requestSerializer = requestSerializer;
    return manger;
}

@end
