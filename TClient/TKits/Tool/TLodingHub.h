//
//  TLodingHub.h
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
@interface TLodingHub : UIView
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gifView;

@property (weak, nonatomic) IBOutlet UILabel *lodingLbl;
/**
 *  设置标题HUD
 *
 *  @param view  父视图
 *  @param title 文字显示
 *
 *  @return HUD
 */
+ (TLodingHub *)setGifOnView:(UIView *)view withTitle:(NSString *)title;

/**
 *  基本方法
 *
 *  @param view  父视图
 *  @param title 显示文字
 *  @param edg   布局调整
 *
 *  @return HUD
 */
+ (TLodingHub *)setGifOnView:(UIView *)view withTitle:(NSString *)title edg:(UIEdgeInsets)edg;

+ (void)hideAllHUDsForView:(UIView *)view;
@end
