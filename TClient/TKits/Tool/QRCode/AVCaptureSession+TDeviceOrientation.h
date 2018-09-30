//
//  AVCaptureSession+TDeviceOrientation.h
//  Examda
//
//  Created by liqi on 2018/1/5.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVCaptureSession (TDeviceOrientation)

+ (AVCaptureVideoOrientation)videoOrientationFromCurrentDeviceOrientation;

@end
