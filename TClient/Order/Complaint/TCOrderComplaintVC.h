//
//  TCOrderComplaintVC.h
//  TClient
//
//  Created by mark_zhang on 2018/11/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TBaseViewcontroller.h"

NS_ASSUME_NONNULL_BEGIN

typedef  NS_ENUM(NSUInteger,TCOrderComplaintType){
    TCOrderComplaintUnclock,//解封订单
    TCOrderComplaintRegister,//注册订单
    
};


@interface TCOrderComplaintVC : TBaseViewcontroller
@property (nonatomic, assign) TCOrderComplaintType complaintType;
@property (nonatomic, assign) NSInteger order_id;
@property (nonatomic, copy) void (^complaintSuccessBlock)(void);
@end

NS_ASSUME_NONNULL_END
