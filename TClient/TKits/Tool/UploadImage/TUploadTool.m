//
//  TUploadTool.m
//  TClient
//
//  Created by Mark on 2018/9/5.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TUploadTool.h"
#import "UIImage+Scale.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+TDigest.h"
@implementation TUploadTool
+ (void)uploadImge:(UIImage *)image finishBlock:(void (^)(NSString *imageUrlString))finishBlock {
    if (![image isKindOfClass:[UIImage class]]) {
        (!finishBlock) ?: finishBlock(@"");
        return;
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://test.168pt.vip/api/Upload/xiadan_qrcode_upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = DateFormatter();
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.45);
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
    } error:nil];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setValue:@"text/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            (!finishBlock) ?:finishBlock(@"");
        } else {
            NSDictionary *dicInfo =   [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dicInfo);
            (!finishBlock)?:finishBlock(dicInfo[@"path"]);
        }
    }];
    [uploadTask resume];
    
}
@end
