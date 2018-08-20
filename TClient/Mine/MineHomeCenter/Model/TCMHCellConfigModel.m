//
//  TCMHCellConfigModel.m
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TCMHCellConfigModel.h"

@implementation TCMHCellConfigModel

- (instancetype)initWithHeadImaName:(NSString *)headImaName title:(NSString *)title actionHandleBlock:(void (^)())actionHandleBlock {
    
    if (self = [super init]) {
        _headImaName = headImaName;
        _title = title;
        _actionHandleBlock = actionHandleBlock;
    }
    return self;
}
@end

@implementation TCMHBasicCellConfigModel
@end

@implementation TCMHInfoCellConfigModel
@end

@implementation TCMHSwitchCellConfigModel
@end



