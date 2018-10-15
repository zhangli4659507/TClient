//
//  TCULODUserInfoCell.h
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const TCULODUserInfoCellClassName;
@interface TCULODUserInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *wxLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbl;
@property (weak, nonatomic) IBOutlet UIButton *unLockButton;
@property (nonatomic, copy) void (^unlockHandlerBlock)();
@end
