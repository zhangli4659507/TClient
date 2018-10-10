//
//  TCCommonSenseModel.h
//  TClient
//
//  Created by mark_zhang on 2018/10/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCCommonSenseModel : NSObject
@property (nonatomic, assign) NSInteger commonID;
@property (nonatomic, assign) NSInteger user_type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *add_time;
@end

@interface TCCommonSenseListModel : NSObject
@property (nonatomic, assign) NSUInteger total_count;
@property (nonatomic, assign) NSUInteger total_pages;
@property (nonatomic, assign) NSUInteger page_size;
@property (nonatomic, assign) NSUInteger page_index;
@property (nonatomic, copy) NSArray<TCCommonSenseModel *> *list;


@end


