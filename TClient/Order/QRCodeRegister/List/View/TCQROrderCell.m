//
//  TCQROrderCell.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCQROrderCell.h"
NSString *const TCQROrderCellClassName = @"TCQROrderCell";
@implementation TCQROrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layoutMargins = UIEdgeInsetsZero;
    self.separatorInset = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = YES;
    // Initialization code
}


- (void)setupUiWithOrderModel:(TCRegisterOrderModel *)orderModel {
    
    self.orderNumLbl.text = [NSString stringWithFormat:@"订单号:%@",orderModel.order_sn];
    self.priceLbl.text = [NSString stringWithFormat:@"单价：%@",orderModel.order_price];
    self.orderReciveLbl.text = [NSString stringWithFormat:@"接单人:%@",orderModel.jd_user_name];
    self.createDateLbl.text = orderModel.add_time;
    self.orderStateLbl.text = orderModel.status_text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
