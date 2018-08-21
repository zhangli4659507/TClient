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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
