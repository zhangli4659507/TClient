//
//  TCRegisterOrderDetailVc.h
//  TClient
//
//  Created by mark_zhang on 2018/11/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TBaseViewcontroller.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCRegisterOrderDetailVc : TBaseViewcontroller
@property (nonatomic, assign) NSInteger order_id;
@property (nonatomic, copy) void (^refreshBlock)(void);
@end

NS_ASSUME_NONNULL_END
