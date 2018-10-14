//
//  TCRechargeRecordCell.h
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCReChargeRecordListModel;
extern NSString *const TCRechargeRecordCellClassName;
@interface TCRechargeRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stateTypeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;
- (void)configWithModel:(TCReChargeRecordListModel *)model;
@end
