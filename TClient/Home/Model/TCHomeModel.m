//
//  TCHomeModel.m
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCHomeModel.h"

@implementation TCHomeMoneyTypeModel

@end

@implementation TCHomeModel
- (void)setCommission_arr:(NSArray *)commission_arr  {
    
    _commission_arr  = commission_arr;
    [self setupConfigArrWithMoneyArr:commission_arr];
}

- (void)setupConfigArrWithMoneyArr:(NSArray *)commission_arr {
    
    NSMutableArray *configArr = [NSMutableArray arrayWithCapacity:commission_arr.count];
    for (NSNumber *money in commission_arr) {
        TCHomeMoneyTypeModel *moneyTypeModel = [[TCHomeMoneyTypeModel alloc] init];
        moneyTypeModel.isFirstSelected = [commission_arr indexOfObject:money] == 0;
        moneyTypeModel.showTitle = [NSString stringWithFormat:@"%@元",money];
        moneyTypeModel.money = [money floatValue];
        [configArr addObject:moneyTypeModel];
    }
    _configArr = [configArr copy];
}

@end


