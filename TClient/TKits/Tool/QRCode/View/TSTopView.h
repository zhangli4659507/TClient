//
//  TSTopView.h
//  Examda
//
//  Created by liqi on 2018/1/5.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBlockTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSTopView : UIView

@property (nonatomic, copy, nullable) VoidBlock openPhotoLibrary;
@property (nonatomic, copy, nullable) VoidBlock closeScanning;

@end

NS_ASSUME_NONNULL_END
