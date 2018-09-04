//
//  TResponse.h
//  TClient
//
//  Created by Mark on 2018/9/4.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TResponse : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id data;
@end
