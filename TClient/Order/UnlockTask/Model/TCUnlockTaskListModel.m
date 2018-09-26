//
//  TCUnlockTaskListModel.m
//  TClient
//
//  Created by mark_zhang on 2018/9/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnlockTaskListModel.h"

@implementation TCOrderUserInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"recordId":@"id"};
}
@end

@implementation TCUnlockOrderModel
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"jd_user_list":[TCOrderUserInfoModel class]};
}
@end

@implementation TCUnlockTaskListModel
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":[TCUnlockOrderModel class]};
}
@end
