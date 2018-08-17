//
//  T2TView.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;
@interface T2TView : UIView

#pragma mark - RoundCornar
/**
 *  设置圆角
 *
 *  @param _v 设置的view
 *  @param r  弧度
 */
+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r;
/**
 *  设置圆角和边框的颜色（默认边框线的宽度为1像素）
 *
 *  @param _v   设置的view
 *  @param r    弧度
 *  @param c_bd 边框颜色
 */
+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd;

/**
 *  设置 圆角和边框的颜色以及边框的线的像素（默认的粗细是1像素）
 *
 *  @param _v   设置的view
 *  @param r    弧度
 *  @param c_bd 边框线的颜色
 *  @param w_bd 边框线的宽度
 */
+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd bdW:(float)w_bd;

/**
 *  设置  给指定的叫设定圆角
 *
 *  @param view        设置的view
 *  @param reectCorner 设置的角度的枚举
 *  @param size        角度大小
 */

+(void)setRonundCornerFor:(UIView *)view byRoundingCorners:(UIRectCorner)reectCorner withSize:(CGSize)size;

@end
