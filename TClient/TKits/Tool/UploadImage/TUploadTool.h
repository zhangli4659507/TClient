//
//  TUploadTool.h
//  TClient
//
//  Created by Mark on 2018/9/5.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUploadTool : NSObject
+ (void)uploadImge:(UIImage *)image finishBlock:(void (^)(NSString *imageUrlString))finishBlock;
@end
