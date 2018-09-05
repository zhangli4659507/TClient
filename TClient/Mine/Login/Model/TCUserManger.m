//
//  TCUserManger.m
//  TClient
//
//  Created by Mark on 2018/9/5.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUserManger.h"

@implementation TCUserManger
+ (instancetype)shareUserManger {
    
    static TCUserManger *manger;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manger = [[TCUserManger alloc] init];
        manger.token = [kUserDefaults objectForKey:TLogin_Token_SaveKey];
    });
    return manger;
}

- (void)loginSuccessReloadWithUserInfo:(NSDictionary *)userInfo mobile:(NSString *)mobile pwd:(NSString *)pwd {
    
    if (![userInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [kUserDefaults setObject:pwd forKey:TLogin_pwd_saveKey];
    [kUserDefaults setObject:mobile forKey:TLogin_Mobile_saveKey];
    WEAK_REF(self);
    self.token = userInfo[@"token"];
    self.user_id = [userInfo[@"user_id"] integerValue];
    [self requestReloadUserInfoWithSuccessBlock:^{
        weak_self.loginState = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:TLogin_success_notiName object:nil];
    }];
}

- (void)requestReloadUserInfoWithSuccessBlock:(void(^)(void))successBlock {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [parInfoDic setObject:@{@"id":@(self.user_id)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"id":@(self.user_id)}];
    
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/user/get_user_info" par:parInfoDic signDicInfo:signDicInfo  finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            self.userModel = [TCUserInfoModel mj_objectWithKeyValues:response.data[@"userinfo"]];
            !successBlock?:successBlock();
        }
    }];
}

- (void)loginOut {
    [kUserDefaults removeObjectForKey:TLogin_pwd_saveKey];
    self.loginState = NO;
    self.token = @"";
    self.user_id = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:TLogin_Out_NotiName object:nil];
}

@end
