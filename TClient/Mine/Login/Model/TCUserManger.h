//
//  TCUserManger.h
//  TClient
//
//  Created by Mark on 2018/9/5.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCUserInfoModel.h"
@interface TCUserManger : NSObject
+ (instancetype)shareUserManger;

@property (nonatomic, assign) BOOL loginState;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) TCUserInfoModel *userModel;
//登录成功后刷新
- (void)loginSuccessReloadWithUserInfo:(NSDictionary *)userInfo mobile:(NSString *)mobile pwd:(NSString *)pwd;
//刷新用户信息
- (void)requestReloadUserInfoWithSuccessBlock:(void(^)(void))successBlock;
//登出
- (void)loginOut;
//更新密码
- (void)reloadPWd:(NSString *)pwd;
@end
