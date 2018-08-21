//
//  TCRechargeRecordCell.m
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCRechargeRecordCell.h"
NSString *const TCRechargeRecordCellClassName = @"TCRechargeRecordCell";
@implementation TCRechargeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorInset = UIEdgeInsetsZero;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
