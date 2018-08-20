//
//  TCMHInfoTableViewCell.m
//  TClient
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCMHInfoTableViewCell.h"
#import "TCMHCellConfigModel.h"
NSString *const TCMHInfoTableViewCellClassName = @"TCMHInfoTableViewCell";
@implementation TCMHInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)configCellWithItemModel:(TCMHCellConfigModel *)itemModel {
    
    self.headImav.image = kImaWithImaName(itemModel.headImaName);
    self.titleLbl.text = kUnNilStr(itemModel.title);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
