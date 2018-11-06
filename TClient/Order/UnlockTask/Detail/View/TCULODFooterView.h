//
//  TCULODFooterView.h
//  TClient
//
//  Created by mark_zhang on 2018/11/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCULODFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (nonatomic, copy) void (^actionOkBlock)(void);
@end

NS_ASSUME_NONNULL_END
