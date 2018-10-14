//
//  TCRechargeRecordSection.m
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCRechargeRecordSection.h"
#import "TCRechargeRecordCell.h"
@implementation TCRechargeRecordSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCRechargeRecordCellClassName forCellReuseIdentifier:TCRechargeRecordCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCRechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:TCRechargeRecordCellClassName];
    if (self.dataSource.count > index) {
        [cell configWithModel:self.dataSource[index]];
    }
    return cell;
}

@end
