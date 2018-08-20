//
//  TOBaseSection.m
//  UnionGroups
//
//  Created by liqi on 2018/5/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TOBaseSection.h"

@implementation TOBaseSection

#pragma mark - Rows

- (void)tableViewRegisterView:(UITableView *)tableView
{
    
}

- (NSInteger)numberOfRowsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
             cellForRowAtIndex:(NSInteger)index
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndex:(NSInteger)index
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndex:(NSInteger)index
{
    
}

#pragma mark - Headers

- (UIView *)viewForHeaderInTableView:(UITableView *)tableView
{
    return nil;
}

- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView
{
    return CGFLOAT_MIN;
}

#pragma mark - Footers

- (UIView *)viewForFooterInTableView:(UITableView *)tableView
{
    return nil;
}

- (CGFloat)heightForFooterInTableView:(UITableView *)tableView
{
    return CGFLOAT_MIN;
}

- (void)dealloc
{
    
}

@end
