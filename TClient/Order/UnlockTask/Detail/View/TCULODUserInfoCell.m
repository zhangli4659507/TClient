//
//  TCULODUserInfoCell.m
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCULODUserInfoCell.h"
NSString *const TCULODUserInfoCellClassName = @"TCULODUserInfoCell";
@implementation TCULODUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [T2TView setRoundCornerFor:self.unLockButton radiu:13.5f];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layoutMargins = UIEdgeInsetsZero;
    self.separatorInset = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = YES;
    // Initialization code
}
- (IBAction)actionUnlockButton:(id)sender {
    !self.unlockHandlerBlock?:self.unlockHandlerBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
