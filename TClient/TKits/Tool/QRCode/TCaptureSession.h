//
//  TCaptureSession.h
//  Examda
//
//  Created by liqi on 2018/1/8.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCaptureSession : NSObject

@property (nonatomic, copy, nullable) void(^getInfoFromScanning)(NSString *content, BOOL success);

- (instancetype)initWithParentView:(UIView *)parentView scanningRect:(CGSize)scanningRect;

- (void)startRunning;

- (void)stopRunning;

@end

NS_ASSUME_NONNULL_END
