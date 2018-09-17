//
//  TCHomeCommissionTypeView.h
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHomeModel.h"

@interface TCHomeCommissionTypeView : UIView
- (CGFloat)reloadWithConfigMoneyArr:(NSArray<TCHomeMoneyTypeModel *> *)configMoney selectModelBlock:(void(^)(TCHomeMoneyTypeModel *typeModel))selectModelBlock width:(CGFloat)width;
@end
