//
//  TOTableViewTool.m
//  UnionGroups
//
//  Created by liqi on 2018/5/11.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TOTableViewTool.h"
// tool
#import "TOBaseSection.h"

@implementation TOTableViewTool

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TOBaseSection *baseSection = self.sectionArray[section];
    return [baseSection numberOfRowsInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TOBaseSection *baseSection = self.sectionArray[indexPath.section];
    return [baseSection tableView:tableView cellForRowAtIndex:indexPath.row];
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TOBaseSection *baseSection = self.sectionArray[indexPath.section];
    [baseSection tableView:tableView didSelectRowAtIndex:indexPath.row];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TOBaseSection *baseSection = self.sectionArray[section];
    return [baseSection viewForFooterInTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    TOBaseSection *baseSection = self.sectionArray[section];
    return [baseSection heightForFooterInTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TOBaseSection *baseSection = self.sectionArray[section];
    return [baseSection viewForHeaderInTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    TOBaseSection *baseSection = self.sectionArray[section];
    return [baseSection heightForHeaderInTableView:tableView];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [scrollView endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

@end
