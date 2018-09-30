//
//  TCUnlockTaskListSection.m
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnlockTaskListSection.h"
#import "TCUnlockListTableViewCell.h"

@implementation TCUnlockTaskListSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCUnlockListTableViewCellClassName forCellReuseIdentifier:TCUnlockListTableViewCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCUnlockListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TCUnlockListTableViewCellClassName];
    if (self.dataSource.count > index) {
        TCUnlockOrderModel *orderModel = self.dataSource[index];
        [cell setupUIWithModel:orderModel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndex:(NSInteger)index {
    
    if (self.dataSource.count > index) {
        !self.didSelectedBlock?:self.didSelectedBlock(self.dataSource[index]);
    }
    
}

@end
