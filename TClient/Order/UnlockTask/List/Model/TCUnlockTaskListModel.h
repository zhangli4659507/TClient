//
//  TCUnlockTaskListModel.h
//  TClient
//
//  Created by mark_zhang on 2018/9/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCOrderUserInfoModel : NSObject
@property (nonatomic, assign) NSInteger recordId;//记录id
@property (nonatomic, assign) NSInteger order_id;//订单id
@property (nonatomic, copy) NSString *jd_phone;//接单用户手机号
@property (nonatomic, copy) NSString *jd_wx_sn;//接单用户微信号
@property (nonatomic, copy) NSString *add_time;//记录添加时间
@property (nonatomic, assign) NSInteger status;//订单状态 0接单成功待完成 1-操作完成 2-订单结束
@end

@interface TCUnlockOrderModel : NSObject
@property (nonatomic, assign) NSInteger order_id;//订单id
@property (nonatomic, copy) NSString *order_sn;//订单编号
@property (nonatomic, copy) NSString *order_price;//订单总价格
@property (nonatomic, copy) NSString *service_price;//平台服务费
@property (nonatomic, copy) NSString *bond_price;//保费
@property (nonatomic, copy) NSString *unseal_price;
@property (nonatomic, assign) NSInteger status;//订单状态 0下单成功 1付款成功 2-保号中 3-待解锁 4-解锁中 5 解锁待确认 6 解锁完成 7 已取消
@property (nonatomic, assign) NSInteger pay_status;//是否解封缴费 0未缴费 1-已缴费（缴费了才能进行指定解封用户操作）
@property (nonatomic, assign) NSInteger type;//订单类型（1有保费 2 无保费）
@property (nonatomic, copy) NSString *add_time;//下单时间
@property (nonatomic, copy) NSString *jd_finish_time;//接单完成
@property (nonatomic, copy) NSString *status_text;//订单状态显示标识
@property (nonatomic, copy) NSArray<TCOrderUserInfoModel *> *jd_user_list;//接单用户列表

@end

@interface TCUnlockTaskListModel : NSObject
@property (nonatomic, assign) NSInteger total_count;//总数
@property (nonatomic, assign) NSInteger total_page;//总页数
@property (nonatomic, assign) NSInteger page_size;//每页显示数
@property (nonatomic, assign) NSInteger page_index;//当前页
@property (nonatomic, copy) NSArray<TCUnlockOrderModel *> *list;//订单数据
@end
