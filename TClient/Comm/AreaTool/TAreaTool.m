//
//  TAreaTool.m
//  TClient
//
//  Created by Mark on 2018/9/5.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TAreaTool.h"

static NSString *const kDataAreaCacheFileName = @"kDataAreaCacheKey";
static NSString *const kDateAreaCacheKey = @"kDateAreaCacheKey";
static NSString *const kAreaListKey = @"kAreaListKey";

@implementation TAreaTool
+ (void)areaModelListWithFinishBlock:(void(^)(NSArray<TAreaModel *> *areaModelList))finishBlock {
    NSFileManager *manger = [NSFileManager defaultManager];
    NSString *fileNamePath = [self fileNamePath];
    if ([manger fileExistsAtPath:fileNamePath]) {
        NSDictionary *dicFile = [NSDictionary dictionaryWithContentsOfFile:fileNamePath];
        NSDate *cacheDate = [dicFile objectForKey:kDateAreaCacheKey];
        NSArray *arrAreaList = [dicFile objectForKey:kAreaListKey];
        if ([self isoverdueWithDate:cacheDate] || !arrAreaList) {
            [self requestModelListWithFinishBlock:finishBlock];
        } else {
           NSArray<TAreaModel *> *areaModelList = [TAreaModel mj_objectArrayWithKeyValuesArray:arrAreaList];
            !finishBlock?:finishBlock(areaModelList);
        }
    } else {
        [self requestModelListWithFinishBlock:finishBlock];
    }
}

+ (BOOL)isoverdueWithDate:(NSDate *)cacheDate {
    NSDate *compareDate = [[NSDate date] earlierDate:cacheDate];
    if (!cacheDate || compareDate == cacheDate) {
        return YES;
    }
    return NO;
}

+ (NSString *)fileDirPath {
    
    NSFileManager *manger = [NSFileManager defaultManager];
    NSString *fileDirPath = kFilePathAtCachWithName(kDataAreaCacheFileName);
    if (![manger fileExistsAtPath:fileDirPath]) {
        [manger createDirectoryAtPath:fileDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return fileDirPath;
}

+ (NSString *)fileNamePath {
    
    NSString *dirPath = [self fileDirPath];
    return [dirPath stringByAppendingPathComponent:@"area.plist"];
}

+ (void)cacheAreaWithArr:(NSArray *)arr {
    NSString *fileName = [self fileNamePath];
    NSTimeInterval cacheTimeInterval = [[NSDate date] timeIntervalSince1970] + kAreaListCacheTime;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:cacheTimeInterval];
    NSDictionary *cacheDicInfo = @{kDateAreaCacheKey:date,kAreaListKey:arr};
   BOOL writeState = [cacheDicInfo writeToFile:fileName atomically:YES];
    if (writeState) {
        NSLog(@"缓存地区文件成功");
    }
}

+ (void)requestModelListWithFinishBlock:(void(^)(NSArray<TAreaModel *> *areaModelList))finishBlock {
    
    [THTTPRequestTool getRequestDataWithUrl:@"api/area/get_province" par:nil finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSArray class]]) {
            [self cacheAreaWithArr:response.data];
            NSArray<TAreaModel *> *areaModelList = [TAreaModel mj_objectArrayWithKeyValuesArray:response.data];
            !finishBlock?:finishBlock(areaModelList);
        } else {
           !finishBlock?:finishBlock(@[]);
        }
    }];
}

@end
