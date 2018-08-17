//
//  TBasicDefine.h
//  TServer
//
//  Created by Mark on 2018/8/17.
//  Copyright © 2018年 Mark. All rights reserved.
//

#ifndef TBasicDefine_h
#define TBasicDefine_h
#ifdef __OBJC__
#import <UIKit/UIKit.h>

#endif

NS_INLINE NSDateFormatter *DateFormatter()
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return formatter;
}

NS_INLINE NSString *TimeMMDDTextWithDatestr(NSString *originalText)
{
    NSDateFormatter *formatter = DateFormatter();
    NSDate *date = [formatter dateFromString:originalText];
    formatter.dateFormat = @"MM-dd";
    NSString *timeText = [formatter stringFromDate:date];
    return timeText;
}

NS_INLINE NSString *TimeYMDTextWithDatestr(NSString *originalText)
{
    NSDateFormatter *formatter = DateFormatter();
    NSDate *date = [formatter dateFromString:originalText];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *timeText = [formatter stringFromDate:date];
    return timeText;
}


#define kIsIOS8 (device_version() >= 8.0)
#define kIsIOS10 (device_version() >= 10.0)
#define kIsIOS11 (device_version() >= 11.0)
#define kIsiOS11Condition @available(iOS 11.0, *)
#define Device_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//当前状态条占的高度
#define kCurrentHeightForStatus CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
//当前状态条最大高度
#define kMaxHeightForStatus (Device_Is_iPhoneX ? 44 : 20)
//导航栏高度
#define kNavBarHeight (Device_Is_iPhoneX ? 88 : 64)
//iPhone X 下部安全区域高度
#define kSafeBottomLayGuideHeight (Device_Is_iPhoneX ? 34 : 0)
#define kCurrentWindow [UIApplication sharedApplication].keyWindow
#define kUnNilStr(str) ((str && ![str isEqual:[NSNull null]])?str:@"")

//整数转换成字符串
#define kStrWithInter(i) [NSString stringWithFormat:@"%d",i]
//float转换成字符串
#define kStrWithFloat(f) [NSString stringWithFormat:@"%0.1f",f]
#define kBOOLToBoolStr(state) (state)?@"True":@"False"
//app名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//app版本
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"

#endif /* TBasicDefine_h */
