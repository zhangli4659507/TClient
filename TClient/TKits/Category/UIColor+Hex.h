//
//  UIColor+Hex.h
//  TYFoundationDemo
//
//  Created by tanyang on 15/12/23.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 *  根据十六进制数生成颜色值
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 文字颜色
 */
+ (UIColor *) colorWithHexString: (NSString *) hexString;

/**
 *  根据十六进制生成颜色
 *
 *  @param hexString 十六进制字符串
 *  @param alpha     透明度
 *
 *  @return 颜色
 */
+(UIColor *) colorWithHexString: (NSString *) hexString alpha:(float)alpha;

@end
