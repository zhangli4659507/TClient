//
//  TCCommonSenseModel.m
//  TClient
//
//  Created by mark_zhang on 2018/10/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCCommonSenseModel.h"

@implementation TCCommonSenseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"commonID":@"id"};
}
@end

@implementation TCCommonSenseListModel
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":[TCCommonSenseModel class]};
}
@end

