//
//  TCMHHeaderCell.h
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const TCMHHeaderCellClassName;
@interface TCMHHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *userInfoBgView;
@property (weak, nonatomic) IBOutlet UIImageView *userInfoBgImav;
@property (weak, nonatomic) IBOutlet UILabel *dateInfoLbl;
@property (weak, nonatomic) IBOutlet UIImageView *headerImav;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *delegateBtn;
@property (weak, nonatomic) IBOutlet UIImageView *adImav;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLbl;
@property (nonatomic, copy) void (^actionRecharge)();
@property (weak, nonatomic) IBOutlet UIButton *RechargeBtn;
- (void)reloadUi;
@end
