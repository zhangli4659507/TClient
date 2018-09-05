//
//  TCLoginViewController.h
//  TClient
//
//  Created by Mark on 2018/8/24.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TBaseViewcontroller.h"

@interface TCLoginViewController : TBaseViewcontroller
@property (nonatomic, copy) void (^loginSuccessBlock)();
@end
