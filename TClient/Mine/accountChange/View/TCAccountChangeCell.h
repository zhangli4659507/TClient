//
//  TCAccountChangeCell.h
//  TClient
//
//  Created by mark_zhang on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const TCAccountChangeCellClassName;
@interface TCAccountChangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
@property (weak, nonatomic) IBOutlet UILabel *changeStateInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateTypeLbl;

@end
