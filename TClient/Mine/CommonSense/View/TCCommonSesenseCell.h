//
//  TCCommonSesenseCell.h
//  TClient
//
//  Created by mark_zhang on 2018/10/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const TCCommonSesenseCellClassName;
@interface TCCommonSesenseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLbl;

@end


