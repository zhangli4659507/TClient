//
//  UIImage+TUtil.m
//  Unions233
//
//  Created by luoluo on 16/3/18.
//  Copyright © 2016年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "UIImage+TUtil.h"

@implementation UIImage (TUtil)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
