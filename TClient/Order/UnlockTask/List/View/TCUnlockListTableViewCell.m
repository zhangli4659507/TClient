//
//  TCUnlockListTableViewCell.m
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnlockListTableViewCell.h"
NSString *const TCUnlockListTableViewCellClassName = @"TCUnlockListTableViewCell";
#import "TCUnlockTaskListModel.h"
@implementation TCUnlockListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layoutMargins = UIEdgeInsetsZero;
    self.separatorInset = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = YES;
    // Initialization code
}

- (void)setupUIWithModel:(TCUnlockOrderModel *)orderModel {
    self.orderNumLbl.text = [NSString stringWithFormat:@"订单号:%ld",orderModel.order_id];
    self.priceLbl.text = [NSString stringWithFormat:@"价格:%@元",kUnNilStr(orderModel.order_price)];
    self.peopleNumLbl.text = [NSString stringWithFormat:@"保号人数:%ld个",orderModel.jd_user_list.count];
    
    self.addDateLbl.text = kUnNilStr(orderModel.add_time);
    self.stateLbl.text = orderModel.status_text;
    self.stateLbl.textColor = [UIColor colorWithHexString:@"#e13b29"];
    if (orderModel.status == 2 || orderModel.status == 3) {
        self.stateLbl.textColor = kThemeColor;
    } else if (orderModel.status == 4) {
        self.stateLbl.textColor = [UIColor colorWithHexString:@"#64B54C"];
    } else if (orderModel.status == 5) {
        self.stateLbl.textColor = [UIColor colorWithHexString:@"#555555"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
