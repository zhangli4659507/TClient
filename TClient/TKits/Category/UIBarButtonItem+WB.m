//
//  UIBarButtonItem+WB.m
//  XinWeibo
//
//  Created by tanyang on 14-10-7.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "UIBarButtonItem+WB.h"
@implementation UIBarButtonItem (WB)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:icon];
    CGSize btnSize = image.size;
    if (image.size.width < 30.f) {
        [button setImage:image forState:UIControlStateNormal];
        if (highlightIcon) {
            [button setImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
        }
        btnSize = CGSizeMake(30.f, button.currentImage.size.height * 30.f / button.currentImage.size.width);;
    } else {
        [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        if (highlightIcon) {
            [button setBackgroundImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
        }else {
            button.adjustsImageWhenHighlighted = NO;
        }
        btnSize = button.currentBackgroundImage.size;
    }
    if (isnan(btnSize.height)) {
        btnSize.height = 0.f;
    }
    button.frame = (CGRect){CGPointZero,btnSize};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (NSArray *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon offsetX:(CGFloat)offsetX target:(id)target action:(SEL)action
{
    UIBarButtonItem *flexBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    flexBarButtonItem.width = - offsetX;
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithIcon:icon highlightIcon:highlightIcon target:target action:action];
    
    return @[flexBarButtonItem,item];
}


+ (UIButton *)buttonWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
    //button.imageView.contentMode = UIViewContentModeCenter;
    CGSize btnSize = button.currentImage.size;
    if (btnSize.width < 30.f) {
        btnSize = CGSizeMake(30.f, button.currentImage.size.height * 30.f / button.currentImage.size.width);
    }
    button.frame = (CGRect){CGPointZero,btnSize};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *image = [UIImage imageNamed:icon];
    CGSize btnSize = image.size;
    if (image.size.width < 30.f) {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
        btnSize = CGSizeMake(30.f * imageScale, button.currentImage.size.height * imageScale * 30.f /button.currentImage.size.width);
    } else {
        [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
        btnSize = button.currentBackgroundImage.size;
    }
    button.frame = (CGRect){CGPointZero,btnSize};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *image = [UIImage imageNamed:icon];
    CGSize btnSize = image.size;
    if (image.size.width < 30.f) {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
        btnSize = CGSizeMake(30.f, button.currentImage.size.height * 30.f / button.currentImage.size.width);
    } else {
        [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
    }
    button.frame = (CGRect){CGPointZero,btnSize};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon disableIcon:(NSString *)disableIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:icon];
    CGSize btnSize = image.size;
    if (btnSize.width < 30.f) {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:disableIcon] forState:UIControlStateDisabled];
        btnSize = CGSizeMake(30.f, button.currentImage.size.height * 30.f / button.currentImage.size.width);
    } else {
        [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:disableIcon] forState:UIControlStateDisabled];
    }
    button.frame = (CGRect){CGPointZero,btnSize};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    return [UIBarButtonItem itemWithIcon:icon highlightIcon:nil target:target action:action];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    return [self itemWithTitle:tilte titleColor:titleColor titleFont:[UIFont systemFontOfSize:14] target:target action:action];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat textWid = [TComputerTextHeightTool textWidthWithString:tilte font:titleFont];
    button.frame = (CGRect){CGPointZero,CGSizeMake(MAX(30.f, textWid), 30.f)};
    [button setTitle:tilte forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (NSArray *)leftItemsWithIcon:(NSString *)icon offsetX:(CGFloat)offsetX
{
    UIImageView *appIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:icon]];
    UIBarButtonItem *flexBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    flexBarButtonItem.width = offsetX;
    UIBarButtonItem *iconBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:appIconView];
    return @[flexBarButtonItem,iconBarButtonItem];
}

+ (UIBarButtonItem *)itemWithFixedSpaceWid:(CGFloat)fixedSpace {
    
    UIBarButtonItem *flexBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    flexBarButtonItem.width =  fixedSpace;
    return flexBarButtonItem;
}


@end
