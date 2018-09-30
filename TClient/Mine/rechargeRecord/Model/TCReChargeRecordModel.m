//
//  TCReChargeRecordModel.m
//  TClient
//
//  Created by Mark on 2018/9/30.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCReChargeRecordModel.h"

@implementation TCReChargeRecordListModel

@end

@implementation TCReChargeRecordModel
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":[TCReChargeRecordListModel class]};
}
@end
