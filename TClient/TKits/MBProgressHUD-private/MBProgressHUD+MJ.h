//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)

/**
 * 展示  图片 + 文字
 *
 * @param text 文字
 * @param icon 图片名字
 * @param view 展示View (nil为当前window)
 * @param time 持续时间
 */
+ (void)show:(NSString *)text
        icon:(NSString *)icon
        view:(UIView *)view
  afterDelay:(NSTimeInterval)time;

#pragma mark 显示成功信息

/**
 * 展示成功信息 图片 + 文字
 *
 * @param success 文字
 * @param view 展示View (nil为当前window)
 * @param time 持续时间
 */
+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view
         afterDelay:(NSTimeInterval)time;

/**
 * 展示成功信息 图片 + 文字
 *
 * @param success 文字
 * @param view 展示View (nil为当前window)
 * @warning 持续时间1.5s
 */
+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view;

/**
 * 展示成功信息 图片 + 文字
 *
 * @param success 文字
 * @param time 持续时间
 * @warning 展示View为当前window
 */
+ (void)showSuccess:(NSString *)success
         afterDelay:(NSTimeInterval)time;

/**
 * 展示成功信息 图片 + 文字
 *
 * @param success 文字
 * @warning 持续时间1.5s
 * @warning 展示View为当前window
 */
+ (void)showSuccess:(NSString *)success;

#pragma mark 显示错误信息

/**
 * 展示失败信息 图片 + 文字
 *
 * @param error 文字
 * @param view 展示View (nil为当前window)
 * @param time 持续时间
 */
+ (void)showError:(NSString *)error
           toView:(UIView *)view
       afterDelay:(NSTimeInterval)time;

/**
 * 展示失败信息 图片 + 文字
 *
 * @param error 文字
 * @param view 展示View (nil为当前window)
 * @warning 持续时间1.5s
 */
+ (void)showError:(NSString *)error
           toView:(UIView *)view;

/**
 * 展示失败信息 图片 + 文字
 *
 * @param error 文字
 * @param time 持续时间
 * @warning 展示View为当前window
 */
+ (void)showError:(NSString *)error
       afterDelay:(NSTimeInterval)time;

/**
 * 展示失败信息 图片 + 文字
 *
 * @param error 文字
 * @warning 持续时间1.5s
 * @warning 展示View为当前window
 */
+ (void)showError:(NSString *)error;

#pragma mark 显示警告信息

/**
 * 展示警告信息 图片 + 文字
 *
 * @param alert 文字
 * @param view 展示View (nil为当前window)
 * @param time 持续时间
 */
+ (void)showAlert:(NSString *)alert
           toView:(UIView *)view
       afterDelay:(NSTimeInterval)time;

/**
 * 展示警告信息 图片 + 文字
 *
 * @param alert 文字
 * @param view 展示View (nil为当前window)
 * @warning 持续时间1.5s
 */
+ (void)showAlert:(NSString *)alert
           toView:(UIView *)view;

/**
 * 展示警告信息 图片 + 文字
 *
 * @param alert 文字
 * @param time 持续时间
 * @warning 展示View为当前window
 */
+ (void)showAlert:(NSString *)alert
       afterDelay:(NSTimeInterval)time;

/**
 * 展示警告信息 图片 + 文字
 *
 * @param alert 文字
 * @warning 持续时间1.5s
 * @warning 展示View为当前window
 */
+ (void)showAlert:(NSString *)alert;

#pragma mark - Other Methods

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;

+ (void)showHUD;

@end
