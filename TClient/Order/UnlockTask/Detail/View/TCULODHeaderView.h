//
//  TCULODHeaderView.h
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCULODHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *platFormPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *bondPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *unlockPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;
@property (weak, nonatomic) IBOutlet UIButton *unLockButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boundPriceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boundPriceSpace;

@end
