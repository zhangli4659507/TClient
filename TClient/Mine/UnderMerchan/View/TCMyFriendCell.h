//
//  TCMyFriendCell.h
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const TCMyFriendCellClassName;
@interface TCMyFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImav;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *appealNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *successNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *appealPercentLbl;
@property (weak, nonatomic) IBOutlet UILabel *successPercentLbl;

@end
