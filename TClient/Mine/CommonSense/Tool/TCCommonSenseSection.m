//
//  TCCommonSenseSection.m
//  TClient
//
//  Created by mark_zhang on 2018/10/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCCommonSenseSection.h"
#import "TCCommonSesenseCell.h"
#import "TCCommonSenseModel.h"
@implementation TCCommonSenseSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCCommonSesenseCellClassName forCellReuseIdentifier:TCCommonSesenseCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCCommonSesenseCell *cell = [tableView dequeueReusableCellWithIdentifier:TCCommonSesenseCellClassName];
    if (self.dataSource.count > index) {
        TCCommonSenseModel *model = self.dataSource[index];
        cell.titleLbl.text = [NSString stringWithFormat:@"公告:%@",model.title];
        cell.contentLbl.text = [NSString stringWithFormat:@"内容:%@",model.content];
        cell.addTimeLbl.text = model.add_time;
    }
    return cell;
    
}

@end
