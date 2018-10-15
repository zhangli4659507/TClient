//
//  TCUserInfoModel.h
//  TClient
//
//  Created by Mark on 2018/9/5.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCUserInfoModel : NSObject
@property (nonatomic, copy) NSString *nickname;//昵称
@property (nonatomic, copy) NSString *mobile;//手机号
@property (nonatomic, copy) NSString *realname;//真实姓名
@property (nonatomic, copy) NSString *alipay;//支付宝账号
@property (nonatomic, copy) NSString *wechat;//微信账号
@property (nonatomic, copy) NSString *qq;//QQ账号
@property (nonatomic, copy) NSString *avatar;//头像链接
@property (nonatomic, copy) NSString *referral_code;//邀请码
@property (nonatomic, copy) NSString *location;//归属地
@property (nonatomic, assign) NSInteger withdraw_type;//支付方式 1支付宝
@property (nonatomic, copy) NSString *type_name;//账户类别
@property (nonatomic, copy) NSString *money;//下单端余额
@property (nonatomic, copy) NSString *jiedan_money;//接单端余额
@property (nonatomic, assign) NSInteger rebate;//返利
@property (nonatomic, assign) NSInteger type;//类型1 放单者
@property (nonatomic, assign) NSInteger jiedan_num;//接单数
@property (nonatomic, copy) NSString *qrcode;//二维码推广链接
@end
