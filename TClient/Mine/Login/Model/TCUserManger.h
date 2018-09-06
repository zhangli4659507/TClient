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
- (void)loginSuccessReloadWithUserInfo:(NSDictionary *)userInfo mobile:(NSString *)mobile pwd:(NSString *)pwd;
//刷新用户信息
- (void)requestReloadUserInfoWithSuccessBlock:(void(^)(void))successBlock;
- (void)loginOut;


@end
