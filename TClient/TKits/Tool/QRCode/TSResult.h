//
//  TSResult.h
//  Examda
//
//  Created by liqi on 2018/1/8.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSResult : NSObject

@property (nonatomic, weak) UIViewController *fromVc;

- (void)dealWithScanResult:(NSString *)resultString;

- (void)failedWithMessage:(NSString *)exceptionMsg;

@end

NS_ASSUME_NONNULL_END
