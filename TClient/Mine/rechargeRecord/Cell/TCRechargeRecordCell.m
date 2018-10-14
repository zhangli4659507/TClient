//
//  TCRechargeRecordCell.m
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCRechargeRecordCell.h"
#import "TCReChargeRecordModel.h"
NSString *const TCRechargeRecordCellClassName = @"TCRechargeRecordCell";
@implementation TCRechargeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layoutMargins = self.separatorInset = UIEdgeInsetsZero;
    // Initialization code
}

- (void)configWithModel:(TCReChargeRecordListModel *)model {
    
    self.priceLbl.text = [NSString stringWithFormat:@"¥%@",model.money];
    self.stateLbl.text = model.status_name;
    self.dateLbl.text = model.create_time;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
