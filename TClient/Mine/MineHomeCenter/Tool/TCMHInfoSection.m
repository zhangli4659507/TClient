//
//  TCMHInfoSection.m
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TCMHInfoSection.h"
#import "TCMHInfoTableViewCell.h"
@implementation TCMHInfoSection

- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCMHInfoTableViewCellClassName forCellReuseIdentifier:TCMHInfoTableViewCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    TCMHInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TCMHInfoTableViewCellClassName];
    return cell;
}

@end
