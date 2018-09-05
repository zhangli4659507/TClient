//
//  EGetCacheSize.m
//  Examda
//
//  Created by mark on 15/1/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EGetCacheSize.h"
#import <sys/stat.h>
#import "ESandBoxTool.h"
#import "ESystemTool.h"
@implementation EGetCacheSize
+(void)getCacheSizeWithFinishBlock:(void (^)(id error))finishBlock{
//  __block  float cacheSize;
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
    NSString *folderPath = [cachePaths objectAtIndex:0];
    
    if (![manager fileExistsAtPath:folderPath]) {
    
        (!finishBlock)?:finishBlock(@"0.0M");
    } else {
        long long size = [ESystemTool folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
         (!finishBlock)?:finishBlock([ESandBoxTool getFileSizeString:kStrWithFloat(size*1.0)]);
    }
}

//得到单个文件大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}


+(void)clearCacheWithFinishBlock:(void (^)())finishBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *ay_filePathInCaches = [[NSFileManager defaultManager] subpathsAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSAllDomainsMask, YES) firstObject]];
        for (NSString *filePath in ay_filePathInCaches) {
            [[NSFileManager defaultManager]removeItemAtPath:kFilePathAtCachWithName(filePath) error:nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock)finishBlock();
        });
    });

}

@end
