//
//  TCHomeModel.h
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCHomeMoneyTypeModel : NSObject
@property (nonatomic, assign) CGFloat money;
@property (nonatomic, assign) BOOL isFirstSelected;
@property (nonatomic, copy) NSString *showTitle;
@end
@interface TCHomeModel : NSObject
@property (nonatomic, assign) CGFloat money;
@property (nonatomic, copy) NSString *index_msg;
@property (nonatomic, copy) NSArray *commission_arr;
@property (nonatomic, copy,readonly) NSArray<TCHomeMoneyTypeModel *> *configArr;
@end
