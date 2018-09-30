//
//  TSResult.m
//  Examda
//
//  Created by liqi on 2018/1/8.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TSResult.h"
// tool
#import "ERedirect.h"
#import "SSDes.h"
// vc
#import "TSFailureController.h"

@implementation TSResult

- (void)dealWithScanResult:(NSString *)resultString
{
    //    NSUInteger l = [resultString rangeOfString:@"http://"].location;
    //    NSUInteger ll = [resultString rangeOfString:@"www"].location;
    NSRange range = [resultString rangeOfString:@"#"];
    if ([resultString rangeOfString:@"https://"].location == NSNotFound && [resultString rangeOfString:@"http://"].location == NSNotFound && [resultString rangeOfString:@"www"].location == NSNotFound && ![resultString hasPrefix:@"wx.233.com"] && ![resultString hasPrefix:@"m.233.com"]) {
        //非url
        [self deCodeString:resultString];
        return;
    }
    if (range.location == NSNotFound ) {
        //无#号 是一个url
        
        if (![resultString hasPrefix:@"http://"] && ![resultString hasPrefix:@"https://"]) {
            resultString =  [@"http://" stringByAppendingString:resultString];
        }
        
        ERedirect *r = [[ERedirect alloc] initWithVC:self.fromVc type:ERedirectedOpenURL data:resultString];
        [ERedirectInterface turnToInterfaceWithModel:r];
        return;
    }
    NSString *handleString = [resultString substringFromIndex:range.location+1];
    [self deCodeString:handleString];
}

- (void)deCodeString:(NSString *)handleString
{
    //解密数据
    NSString *decryptString = [SSDes getDecryptWithString:handleString keyString:@"ea9377ea" ivString:nil];
    NSDictionary *dataDict = [EAPPUnit dictionaryWithJsonString:decryptString];
    ERedirect *r = [ERedirect mj_objectWithKeyValues:dataDict];
    r.fromController = self.fromVc;
    if (!r) {
        //解析json失败
        [self failedWithMessage:@"解析失败！"];
        return;
    }
    [ERedirectInterface turnToInterfaceWithModel:r];
}

- (void)failedWithMessage:(NSString *)exceptionMsg
{
    [TRouterTool routerWithUrl:ShortURL_TSFailureController fromVc:self.fromVc.navigationController parameters:@{@"msg":kUnNilStr(exceptionMsg)}];
}

@end
