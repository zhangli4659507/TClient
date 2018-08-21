//
//  TCAccountChangeSection.m
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCAccountChangeSection.h"
#import "TCAccountChangeCell.h"
@implementation TCAccountChangeSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCAccountChangeCellClassName forCellReuseIdentifier:TCAccountChangeCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCAccountChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:TCAccountChangeCellClassName];
    return cell;
    
}

@end
