//
//  TCReChargeRecordModel.h
//  TClient
//
//  Created by Mark on 2018/9/30.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TCReChargeRecordListModel :NSObject

@property (nonatomic, copy) NSString *money;//充值金额
@property (nonatomic, assign) NSInteger status;//充值状态
@property (nonatomic, copy) NSString *create_time;//充值时间
@property (nonatomic, copy) NSString *status_name;//充值状态

@end

@interface TCReChargeRecordModel : NSObject
@property (nonatomic, assign) NSInteger total_count;
@property (nonatomic, assign) NSInteger total_pages;
@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) NSInteger page_index;
@property (nonatomic, copy) NSArray<TCReChargeRecordListModel *> *list;


@end
