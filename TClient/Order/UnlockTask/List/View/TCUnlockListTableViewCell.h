//
//  TCUnlockListTableViewCell.h
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCUnlockOrderModel;
extern NSString *const TCUnlockListTableViewCellClassName;
@interface TCUnlockListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *addDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;
- (void)setupUIWithModel:(TCUnlockOrderModel *)orderModel;
@end
