//
//  TCMyFriendCell.m
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCMyFriendCell.h"
NSString *const TCMyFriendCellClassName = @"TCMyFriendCell";
@implementation TCMyFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layoutMargins = self.separatorInset = UIEdgeInsetsZero;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
