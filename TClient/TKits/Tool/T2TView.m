//
//  T2TView.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TView.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
@implementation T2TView
#pragma mark - RoundCornar

+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd bdW:(float)w_bd{
    _v.layer.masksToBounds = YES;
    _v.layer.cornerRadius = r;
    _v.layer.borderWidth = w_bd;
    _v.layer.borderColor = c_bd.CGColor;
}

+(void)setRonundCornerFor:(UIView *)view byRoundingCorners:(UIRectCorner)reectCorner withSize:(CGSize)size{

    UIBezierPath *bzPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:reectCorner cornerRadii:size];
    view.layer.masksToBounds = YES;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = bzPath.CGPath;
    view.layer.mask = maskLayer;
}

+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd{
    [self setRoundCornerFor:_v radiu:r bdColor:c_bd bdW:1];
}

+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r{
    
    [self setRoundCornerFor:_v radiu:r bdColor:[UIColor clearColor] bdW:1];
    
}



@end
