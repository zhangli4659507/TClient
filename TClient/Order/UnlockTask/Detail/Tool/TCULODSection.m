//
//  TCULODSection.m
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCULODSection.h"
#import "TCULODUserInfoCell.h"
@implementation TCULODSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCULODUserInfoCellClassName forCellReuseIdentifier:TCULODUserInfoCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCULODUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:TCULODUserInfoCellClassName];
    return cell;
}

@end
