//
//  THTTPRequestTool.h
//  TClient
//
//  Created by Mark on 2018/9/4.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResponse.h"
/**
 请求成功 200
 */
extern NSInteger const TRequestSuccessCode;
/**
 未授权 401 //未登录或者登录超时
 */
extern NSInteger const TRequestUnauthorizedCode;
/**
 参数为空 40001
 */
extern NSInteger const TRequestParNullCode;

/**
 结果为找到 40004
 */
extern NSInteger const TRequestNotFindResultCode;
/**
 服务器返回数据失败 0
 */
extern NSInteger const TRequestServerUnusualCode;
/**
 服务器返回数据失败 500
 */
extern NSInteger const TRequestNetConnectFailedCode;

@interface THTTPRequestTool : NSObject

+ (void)getRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic finishBlock:(void(^)(TResponse *response))finshBlock;

+ (void)postRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic finishBlock:(void(^)(TResponse *response))finshBlock;

+ (void)getSignRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic signDicInfo:(NSDictionary *)signDicInfo finishBlock:(void(^)(TResponse *response))finshBlock;

+ (void)postSignRequestDataWithUrl:(NSString *)url par:(NSDictionary *)parDic signDicInfo:(NSDictionary *)signDicInfo finishBlock:(void(^)(TResponse *response))finshBlock;

@end
