//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)

#pragma mark 显示信息

+ (void)show:(NSString *)text
        icon:(NSString *)icon
        view:(UIView *)view
  afterDelay:(NSTimeInterval)time
{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.minSize = CGSizeMake(120, 115);
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.detailsLabelText = text;
    hud.margin = 70.0f;
    hud.vPadding = 17.5;
    hud.hPadding = 17.5;
    // 设置图片
    //NSParameterAssert(icon && icon.length);
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.square = NO;
    // time秒之后再消失
    [hud hide:YES afterDelay:time];
}

#pragma mark 显示成功信息

+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view
         afterDelay:(NSTimeInterval)time
{
    [self show:success icon:@"community_icon_ok" view:view afterDelay:time];
}

+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view
{
    [self showSuccess:success toView:view afterDelay:1.5];
}

+ (void)showSuccess:(NSString *)success
         afterDelay:(NSTimeInterval)time
{
    [self showSuccess:success toView:nil afterDelay:time];
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success afterDelay:1.5];
}

#pragma mark 显示警告信息

+ (void)showAlert:(NSString *)alert
           toView:(UIView *)view
       afterDelay:(NSTimeInterval)time
{
    [self show:alert icon:@"community_icon_alert" view:view afterDelay:time];
}

+ (void)showAlert:(NSString *)alert
           toView:(UIView *)view
{
    [self showAlert:alert toView:view afterDelay:1.5];
}

+ (void)showAlert:(NSString *)alert
       afterDelay:(NSTimeInterval)time
{
    [self showAlert:alert toView:nil afterDelay:time];
}

+ (void)showAlert:(NSString *)message
{
    [self showAlert:message afterDelay:1.5];
}

#pragma mark 显示错误信息

+ (void)showError:(NSString *)error
           toView:(UIView *)view
       afterDelay:(NSTimeInterval)time
{
    [self show:error icon:@"community_icon_no" view:view afterDelay:time];
}

+ (void)showError:(NSString *)error
           toView:(UIView *)view
{
    [self showError:error toView:view afterDelay:1.5];
}

+ (void)showError:(NSString *)error
       afterDelay:(NSTimeInterval)time
{
    [self showError:error toView:nil afterDelay:time];
}

+ (void)showError:(NSString *)error
{
    [self showError:error afterDelay:1.5];
}


#pragma mark 显示一些信息

+ (MBProgressHUD *)showMessage:(NSString *)message
                        toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
     [MBProgressHUD hideAllHUDsForView:view animated:NO];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
     hud.detailsLabelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    hud.vPadding = 17.5;
    hud.hPadding = 17.5;
    hud.margin = 70.0f;
    hud.minSize = CGSizeMake(120, 115);
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)showHUD
{
    [self showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
