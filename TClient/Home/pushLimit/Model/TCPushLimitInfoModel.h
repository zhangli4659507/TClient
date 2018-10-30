//
//  TCPushLimitInfoModel.h
//  TClient
//
//  Created by mark_zhang on 2018/9/18.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPushLimitInfoModel : NSObject
@property (nonatomic, assign) CGFloat service_price;//平台服务费
@property (nonatomic, assign) CGFloat bond_price;//保费
@property (nonatomic, assign) CGFloat bond_section_begin_price;//有保费的起始金额
@property (nonatomic, assign) CGFloat bond_section_end_price;//有保费的结束金额
@property (nonatomic, assign) CGFloat nobond_section_begin_price;//没有保费的起始金额
@property (nonatomic, assign) CGFloat nobond_section_end_price;//没有保费的结束金额
@property (nonatomic, copy) NSString *describe;//描述
@property (nonatomic, copy) NSArray<NSNumber *> *unseal_price;//解封佣金
@end
