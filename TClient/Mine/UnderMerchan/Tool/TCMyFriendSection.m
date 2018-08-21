//
//  TCMyFriendSection.m
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCMyFriendSection.h"
#import "TCMyFriendCell.h"
#import "TCMyFriendSectionHeaderView.h"
@implementation TCMyFriendSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCMyFriendCellClassName forCellReuseIdentifier:TCMyFriendCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCMyFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:TCMyFriendCellClassName];
    return cell;
}

- (UIView *)viewForHeaderInTableView:(UITableView *)tableView {
    
    TCMyFriendSectionHeaderView *headerView = [TCMyFriendSectionHeaderView loadInstanceFromNib];
    return headerView;
}

- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView {
    
    return 40.f;
}

@end
