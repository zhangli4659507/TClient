//
//  TCMHHeaderCell.m
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TCMHHeaderCell.h"
#import "T2TView.h"
NSString *const TCMHHeaderCellClassName = @"TCMHHeaderCell";
@implementation TCMHHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [T2TView setRoundCornerFor:self.headerImav radiu:21.5f];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
