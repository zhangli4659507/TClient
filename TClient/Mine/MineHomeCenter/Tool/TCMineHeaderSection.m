//
//  TCMineHeaderSection.m
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TCMineHeaderSection.h"
#import "TCMHHeaderCell.h"
#import "TCMHCellConfigModel.h"
@implementation TCMineHeaderSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCMHHeaderCellClassName forCellReuseIdentifier:TCMHHeaderCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCMHHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:TCMHHeaderCellClassName];
    return cell;
    }


- (UIView *)viewForFooterInTableView:(UITableView *)tableView {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    return view;
}

- (CGFloat)heightForFooterInTableView:(UITableView *)tableView {
    
    return 10.f;
}

@end
