//
//  TCAccountChangeModel.h
//  TClient
//
//  Created by Mark on 2018/10/11.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TCAccountChangeListModel : NSObject

@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign) NSInteger source;
@property (nonatomic, assign) NSInteger source_type;// 0是收入 1支出
@property (nonatomic, copy) NSString *remaining;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *source_type_name;
@property (nonatomic, copy) NSString *source_name;
@property (nonatomic, assign) CGFloat money_before;
@end


@interface TCAccountChangeModel : NSObject
@property (nonatomic, assign) NSInteger total_count;
@property (nonatomic, assign) NSInteger total_pages;
@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) NSInteger page_index;
@property (nonatomic, copy) NSArray<TCAccountChangeListModel *> *list;
@end
