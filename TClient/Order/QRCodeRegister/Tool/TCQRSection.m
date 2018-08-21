//
//  TCQRSection.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCQRSection.h"
#import "TCQROrderCell.h"
@implementation TCQRSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCQROrderCellClassName forCellReuseIdentifier:TCQROrderCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    TCQROrderCell *cell = [tableView dequeueReusableCellWithIdentifier:TCQROrderCellClassName];
    return cell;
}

@end
