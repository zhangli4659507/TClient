//
//  EGetCacheSize.h
//  Examda
//
//  Created by mark on 15/1/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  获取缓存大小以及清除缓存
 */
@interface EGetCacheSize : NSObject

//获取缓存大小
+(void)getCacheSizeWithFinishBlock:(void (^)(id error))finishBlock;
//清除缓存
+(void)clearCacheWithFinishBlock:(void (^)())finishBlock;
@end
