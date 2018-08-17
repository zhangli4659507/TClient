//
//  UIBarButtonItem+WB.h
//  XinWeibo
//
//  Created by tanyang on 14-10-7.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIBarButtonItem (WB)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action;

+ (NSArray *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon offsetX:(CGFloat)offsetX target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon disableIcon:(NSString *)disableIcon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont target:(id)target action:(SEL)action;

/**
 *  创建left 图片item
 *
 *  @param icon    图片
 *  @param offsetX x上位移
 *
 *  @return UIBarButtonItems 数组
 */
+ (NSArray *)leftItemsWithIcon:(NSString *)icon offsetX:(CGFloat)offsetX;

/**
 创建

 @param fixedSpace 偏移距离（width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整为0；width为正数时，正好相反，相当于往左移动width数值个像素）
 @return item
 */
+ (UIBarButtonItem *)itemWithFixedSpaceWid:(CGFloat)fixedSpace;

@end
