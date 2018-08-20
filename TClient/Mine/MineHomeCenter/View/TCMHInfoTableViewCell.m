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
    self.switchBgView.hidden = self.infoTextBgView.hidden = self.rightImaBgView.hidden = YES;
    if ([itemModel isKindOfClass:[TCMHBasicCellConfigModel class]]) {
        self.rightImaBgView.hidden = NO;
        TCMHBasicCellConfigModel *infoItemModel = (TCMHBasicCellConfigModel *)itemModel;
        self.rightInfoLbl.hidden = infoItemModel.rightInfo.length == 0;
        self.rightInfoLbl.text = kUnNilStr(infoItemModel.rightInfo);
    } else if ([itemModel isKindOfClass:[TCMHSwitchCellConfigModel class]]) {
        self.switchBgView.hidden = NO;
        
    } else if ([itemModel isKindOfClass:[TCMHInfoCellConfigModel class]]) {
        self.infoTextBgView.hidden = NO;
        TCMHInfoCellConfigModel *infoItemModel = (TCMHInfoCellConfigModel *)itemModel;
        self.infoTextLbl.text = infoItemModel.info;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
