//
//  TAreaTool.h
//  TClient
//
//  Created by Mark on 2018/9/5.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAreaModel.h"
static NSTimeInterval const kAreaListCacheTime = 7 * 24 * 60 * 60;//地区缓存时间为7天
@interface TAreaTool : NSObject
+ (void)areaModelListWithFinishBlock:(void(^)(NSArray<TAreaModel *> *areaModelList))finishBlock;
@end
