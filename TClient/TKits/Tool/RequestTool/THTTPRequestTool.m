//
//  THTTPRequestTool.m
//  TClient
//
//  Created by Mark on 2018/9/4.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "THTTPRequestTool.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+MD5.h"
static NSString *const BaseUrl = @"http://test.168pt.vip";
NSInteger const TRequestSuccessCode = 200;
NSInteger const TRequestUnauthorizedCode = 401;
NSInteger const TRequestParNullCode = 40001;
NSInteger const TRequestNotFindResultCode = 40004;
NSInteger const TRequestServerUnusualCode = 0;
NSInteger const TRequestNetConnectFailedCode = 500;
@implementation THTTPRequestTool
+ (void)getRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic finishBlock:(void(^)(TResponse *response))finshBlock {
    
    AFHTTPSessionManager *manger = [self netSessionManger];
    [manger GET:url parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     [self requestResponse:responseObject task:task finishBlock:finshBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestResponse:nil task:task finishBlock:finshBlock];
        
    }];
}

+ (void)postRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic finishBlock:(void(^)(TResponse *response))finshBlock {
    
    AFHTTPSessionManager *manger = [self netSessionManger];
    [manger POST:url parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestResponse:responseObject task:task finishBlock:finshBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestResponse:nil task:task finishBlock:finshBlock];
    }];
}

+ (void)getSignRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic signDicInfo:(NSDictionary *)signDicInfo finishBlock:(void(^)(TResponse *response))finshBlock {
    
    NSMutableDictionary *newdicPar = [NSMutableDictionary dictionaryWithDictionary:parDic];
    NSString *sign = [self signStrInfoWithParDic:signDicInfo];
    [newdicPar setObject:kUnNilStr(sign) forKey:@"sign"];
    [self getRequestDataWithUrl:url par:newdicPar finishBlock:finshBlock];
    
}

+ (void)postSignRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic signDicInfo:(NSDictionary *)signDicInfo finishBlock:(void(^)(TResponse *response))finshBlock {
    
    NSMutableDictionary *newdicPar = [NSMutableDictionary dictionaryWithDictionary:parDic];
    NSString *sign = [self signStrInfoWithParDic:signDicInfo];
    [newdicPar setObject:kUnNilStr(sign) forKey:@"sign"];
    [self postRequestDataWithUrl:url par:newdicPar finishBlock:finshBlock];
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
        if (responseObj.code == TRequestUnauthorizedCode) {
            [[TCUserManger shareUserManger] loginOut];
        }
    }
}

+ (NSString *)signStrInfoWithParDic:(NSDictionary *)dicInfo {
    
    NSString *parStr = [self parToStringWithDicInfo:dicInfo];
    NSString *signStr = [NSString stringWithFormat:@"%@&%@&%@",TSecret_key_Str,parStr,TSecret_key_Str];
    NSString *md5_signStr = [signStr md5String];
    return md5_signStr;
}

+ (NSString *)parToStringWithDicInfo:(NSDictionary *)dicInfo {
    
    NSMutableArray *parArr = [NSMutableArray array];
    NSArray *sortkey = [dicInfo.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in sortkey) {
        id keyValue = dicInfo[key];
        NSString *strValue = [NSString stringWithFormat:@"%@",keyValue];
        if (strValue.length > 0) {
         NSString *strPar = [NSString stringWithFormat:@"%@=%@",key,strValue];
         [parArr addObject:strPar];
        }
    }
    return [parArr componentsJoinedByString:@"&"];
}

+ (AFHTTPSessionManager *)netSessionManger  {
    
    static AFHTTPSessionManager *manger;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       manger = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
       manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
    });
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    if ([TCUserManger shareUserManger].token.length > 0) {
     [requestSerializer setValue:[TCUserManger shareUserManger].token forHTTPHeaderField:@"token"];
    }
    manger.requestSerializer = requestSerializer;
    return manger;
}

@end
