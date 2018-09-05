//
//  ESandBoxTool.m
//  Examda
//
//  Created by luoluo on 15/1/16.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "ESandBoxTool.h"

@implementation ESandBoxTool
+ (NSString *)homePath
{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES)[0];
    return path;
}



+ (NSString *)docPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return path;
}

+ (NSString *)libPrefPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingFormat:@"/Caches"];
    
}

+ (NSString *)tmpPath
{
    return [[self homePath] stringByAppendingFormat:@"/tmp"];
}

+ (BOOL)fileDirectoryIsExistsAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (NSString *)fileLocalPath:(NSString *)subPath
{
    NSString *path = [[self docPath] stringByAppendingPathComponent:@"courseVideo"];
    path = [path stringByAppendingPathComponent:subPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                     error:NULL];
    }
    return path;
}


+ (NSString *)fileTempPath
{
    NSString *path = [[self docPath] stringByAppendingPathComponent:@"Temps"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
    }
    return path;
}

//创建Temps CourseVideo 设置不被iTunes icloud备份同步
+ (void)setUpCourseSkipBackupAttribute
{
    [self addSkipBackupAttributeToItemAtPath:[self fileLocalPath:@""]];
    [self addSkipBackupAttributeToItemAtPath:[self fileTempPath]];
}

+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString
{
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (CGFloat)getProgress:(CGFloat)totalSize currentSize:(CGFloat)currentSize
{
    if (totalSize == 0) {
        return 0;
    } else
        return currentSize/totalSize;
}

+(NSString *)getFileSizeString:(NSString *)size
{
    if([size floatValue]>=1024*1024)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%1.0fM",[size floatValue]/1024/1024];
    }
    else if([size floatValue]>=1024&&[size floatValue]<1024*1024) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%1.0fK",[size floatValue]/1024];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%1.1fB",[size floatValue]];
    }
}
@end
