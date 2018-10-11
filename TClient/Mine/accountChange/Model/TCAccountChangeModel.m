//
//  TCAccountChangeModel.m
//  TClient
//
//  Created by Mark on 2018/10/11.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCAccountChangeModel.h"

@implementation TCAccountChangeListModel

@end

@implementation TCAccountChangeModel
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":[TCAccountChangeListModel class]};
}
@end
