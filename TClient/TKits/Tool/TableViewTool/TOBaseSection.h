//
//  TOBaseSection.h
//  UnionGroups
//
//  Created by liqi on 2018/5/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOBaseSection : NSObject

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, strong) id model;

@property (nonatomic, copy) void(^didSelectedBlock)(id model);

#pragma mark - Rows

// override by sub
- (void)tableViewRegisterView:(UITableView *)tableView;

// override by sub
- (NSInteger)numberOfRowsInTableView:(UITableView *)tableView;

// override by sub
- (UITableViewCell *)tableView:(UITableView *)tableView
             cellForRowAtIndex:(NSInteger)index;

// override by sub
- (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndex:(NSInteger)index;

// override by sub
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndex:(NSInteger)index;

#pragma mark - Headers

// override by sub
- (nullable UIView *)viewForHeaderInTableView:(UITableView *)tableView;

// override by sub
- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView;

#pragma mark - Footers

// override by sub
- (nullable UIView *)viewForFooterInTableView:(UITableView *)tableView;

// override by sub
- (CGFloat)heightForFooterInTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
