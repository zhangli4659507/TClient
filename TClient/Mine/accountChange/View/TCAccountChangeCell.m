//
//  TCAccountChangeCell.m
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCAccountChangeCell.h"
#import "TCAccountChangeModel.h"
NSString *const TCAccountChangeCellClassName = @"TCAccountChangeCell";
@implementation TCAccountChangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layoutMargins = self.separatorInset = UIEdgeInsetsZero;
    // Initialization code
}

- (void)configDataWithModel:(TCAccountChangeListModel *)model {
    
    NSString *tagString = @"";
    
    if (model.source_type == 0) {
        //收入
        tagString = @"+";
        self.stateTypeLbl.textColor = [UIColor colorWithHexString:@"#64B54C"];
    } else {
        self.stateTypeLbl.textColor = [UIColor colorWithHexString:@"#e13b29"];
    }
    
    self.infoLbl.text = [NSString stringWithFormat:@"%@%@%@",model.source_name,tagString,model.money];
    self.changeStateInfoLbl.text = [NSString stringWithFormat:@"变动前:¥%.2lf  变动后:¥%@",model.money_before,model.remaining];
    self.dateLbl.text = kUnNilStr(model.add_time);
    self.stateTypeLbl.text = model.source_type == 0 ?@"收入":@"支出";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
