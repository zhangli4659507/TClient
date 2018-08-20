//
//  TCMHInfoTableViewCell.h
//  TClient
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCMHCellConfigModel;
extern NSString *const TCMHInfoTableViewCellClassName;
@interface TCMHInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImav;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *rightImaBgView;
@property (weak, nonatomic) IBOutlet UIView *infoTextBgView;
@property (weak, nonatomic) IBOutlet UILabel *infoTextLbl;
@property (weak, nonatomic) IBOutlet UILabel *rightInfoLbl;
@property (weak, nonatomic) IBOutlet UIView *switchBgView;
@property (weak, nonatomic) IBOutlet UISwitch *voiceSwitch;
- (void)configCellWithItemModel:(TCMHCellConfigModel *)itemModel;
@end
