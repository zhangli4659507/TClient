//
//  TCChangePwdViewController.h
//  TClient
//
//  Created by Mark on 2018/9/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TBaseViewcontroller.h"
typedef NS_ENUM(NSInteger,TChangePwdType) {
    TChangePwdOfReset = 0,//修改密码
    TChangePwdOfFind = 1,//找回密码
};
@interface TCChangePwdViewController : TBaseViewcontroller
@property (nonatomic, assign) TChangePwdType changePwdType;//默认是修改密码
@end
