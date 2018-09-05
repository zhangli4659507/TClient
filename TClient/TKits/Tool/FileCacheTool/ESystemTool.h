//
//  ESystemTool.h
//  Examda
//
//  Created by SunYong on 15/4/1.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESystemTool : NSObject

// 剩余空间
+ (long long)freeDiskSpaceInBytes;

// 文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath;

// 文件夹大小
+ (long long)folderSizeAtPath: (const char*)folderPath;
@end
