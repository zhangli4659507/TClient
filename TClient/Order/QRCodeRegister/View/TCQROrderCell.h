//
//  TCQROrderCell.h
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const TCQROrderCellClassName;
@interface TCQROrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderReciveLbl;
@property (weak, nonatomic) IBOutlet UILabel *createDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLbl;

@end
