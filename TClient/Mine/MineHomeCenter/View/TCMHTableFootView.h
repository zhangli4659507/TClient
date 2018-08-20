//
//  TCMHTableFootView.h
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TCMHTableFootView : UIView
@property (weak, nonatomic) IBOutlet UIButton *loginOutBtn;
@property (nonatomic, copy) void (^actionLoginOut)();
@end
