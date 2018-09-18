//
//  TFailhub.h
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFailhub : UIView
@property (weak, nonatomic) IBOutlet UIImageView *typeImav;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
@property (nonatomic, copy) void (^reloadBlock)(void);
+ (TFailhub *)showFailHubWithSuperView:(UIView *)superView  reloadBlock:(void(^)(void))reloadBlock;
+ (TFailhub *)showFailHubWithSuperView:(UIView *)superView  edg:(UIEdgeInsets)edg reloadBlock:(void(^)(void))reloadBlock;
+ (void)hidenALLFailhubWithSuperView:(UIView *)superView;
@end
