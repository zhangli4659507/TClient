//
//  TComputerTextHeightTool.h
//  Examda
//
//  Created by Mark on 2017/5/4.
//  Copyright © 2017年 长沙二三三网络科技有限公司. All rights reserved.
// 计算文本高度

#import <Foundation/Foundation.h>

@interface TComputerTextHeightTool : NSObject

/**
 根据宽度计算文本高度

 @param string 需计算的字符串
 @param font 字体
 @param lineSpace 行距
 @param wid 宽度
 @return 文本高度
 */
+ (CGFloat)textHeightWithString:(NSString *)string font:(UIFont *)font lineSpace:(CGFloat)lineSpace wid:(CGFloat)wid;

/**
 计算单行文本宽度

 @param string 文本字符串
 @param font 字体
 @return 宽度
 */
+ (CGFloat)textWidthWithString:(NSString *)string font:(UIFont *)font;

+ (NSMutableAttributedString *)createAttWithFont:(UIFont *)font lineSpace:(CGFloat)lineSpace string:(NSString *)string;
@end
