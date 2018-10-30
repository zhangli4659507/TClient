//
//  TCUnsealPriceTableViewCell.m
//  TClient
//
//  Created by mark_zhang on 2018/10/30.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnsealPriceTableViewCell.h"
NSString *const TCUnsealPriceTableViewCellClassName = @"TCUnsealPriceTableViewCell";
@implementation TCUnsealPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layoutMargins = UIEdgeInsetsZero;
    self.separatorInset = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
