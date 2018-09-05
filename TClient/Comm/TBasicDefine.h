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

#ifdef DEBUG
#define NSLog(...) printf("[%s] %s\n",[[[NSDate date] description] UTF8String],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSSLog(...)
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

static NSString *const TLogin_success_notiName = @"TLogin_success_notiName";
static NSString *const TLogin_Out_NotiName = @"TLogin_Out_NotiName";
static NSString *const TLogin_Token_SaveKey = @"TLogin_Token_SaveKey";
static NSString *const TLogin_Mobile_saveKey = @"TLogin_Mobile_saveKey";
static NSString *const TLogin_pwd_saveKey = @"TLogin_pwd_saveKey";

static NSString *const TApi_key_Str = @"wmi";
static NSString *const TSecret_key_Str = @"FF850EABD8BCAF3BCF2E0695B1C4C8FD";

#define WEAK_REF(obj)\
__weak typeof(obj) weak_##obj = obj; \

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
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kImaWithImaName(str)  [UIImage imageNamed:str]
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kDefaultHeadImg [UIImage imageNamed:@"ico_head_portrait"]
#define kThemeColor  [UIColor colorWithHexString:@"#279AF9"]
#define kFilePathAtCachWithName(fileNAme) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileNAme]
//缓存路径-document目录
#define kFilePathAtDocumentWithName(fileNAme) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileNAme]

#endif /* TBasicDefine_h */
