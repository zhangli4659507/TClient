//
//  TScanController.h
//  Examda
//
//  Created by liqi on 2018/1/5.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

// 二维码扫描组件

#import <UIKit/UIKit.h>

@interface TScanController : UIViewController
@property (nonatomic, copy) void (^scanSuccessBlock)(NSString *successUrl);
@end
