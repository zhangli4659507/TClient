//
//  TTabBarViewController.h
//  TServer
//
//  Created by Mark on 2018/8/17.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNavViewController.h"
@interface TTabbarConfig : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imaName;
@property (nonatomic, copy) NSString *imaSelectName;
@property (nonatomic, strong) TNavViewController *vc;
- (instancetype)initWithTitle:(NSString *)title imaName:(NSString *)imaName imaSelectName:(NSString *)imaSelectName vc:(TNavViewController *)vc;
@end
@interface TTabBarViewController : UITabBarController
- (instancetype)initWithConfigArr:(NSArray<TTabbarConfig *> *)configArr;
@end
