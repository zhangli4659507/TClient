//
//  TSPhotoPicker.h
//  Examda
//
//  Created by liqi on 2018/1/8.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TSPhotoPicker : NSObject

@property (nonatomic, copy, nullable) void(^getInfoFromImage)(NSString *content, BOOL success);

- (instancetype)initWithParentController:(UIViewController *)parentController;

- (BOOL)check;

- (void)open;

@end

NS_ASSUME_NONNULL_END
