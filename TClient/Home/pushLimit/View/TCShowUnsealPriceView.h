//
//  TCShowUnsealPriceView.h
//  TClient
//
//  Created by mark_zhang on 2018/10/30.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCShowUnsealPriceView : UIView
+ (void)showUnsealPriceViewWithUnsealPriceArr:(NSArray<NSNumber *> *)unsealPriceArray selectBlock:(void(^)(CGFloat unsealPrice))selectBlock;
@end

NS_ASSUME_NONNULL_END
