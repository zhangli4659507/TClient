//
//  TCMHCellConfigModel.h
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCMHCellConfigModel : NSObject
@property (nonatomic, copy) NSString *headImaName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^actionHandleBlock)();

- (instancetype)initWithHeadImaName:(NSString *)headImaName title:(NSString *)title actionHandleBlock:(void (^)())actionHandleBlock;


@end


@interface TCMHBasicCellConfigModel : TCMHCellConfigModel
@property (nonatomic, copy) NSString *rightInfo;
@end


@interface TCMHInfoCellConfigModel : TCMHCellConfigModel
@property (nonatomic, copy) NSString *info;
@end

@interface TCMHSwitchCellConfigModel : TCMHCellConfigModel
@property (nonatomic, assign) BOOL switchState;
@end




