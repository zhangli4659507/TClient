//
//  TCULODSection.m
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCULODSection.h"
#import "TCULODUserInfoCell.h"
#import "TCUnlockTaskListModel.h"
@implementation TCULODSection
- (void)tableViewRegisterView:(UITableView *)tableView {
    
    [tableView registerNibName:TCULODUserInfoCellClassName forCellReuseIdentifier:TCULODUserInfoCellClassName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)index {
    
    TCULODUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:TCULODUserInfoCellClassName];
    if (self.dataSource.count > index) {
        TCOrderUserInfoModel *userInfoModel = self.dataSource[index];
        cell.wxLbl.text = kUnNilStr(userInfoModel.jd_wx_sn);
        cell.phoneNumLbl.text = kUnNilStr(userInfoModel.jd_phone);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndex:(NSInteger)index {
    
    return 40.f;
}

@end
