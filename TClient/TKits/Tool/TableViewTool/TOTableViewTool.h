//
//  TOTableViewTool.h
//  UnionGroups
//
//  Created by liqi on 2018/5/11.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TOBaseSection;
@interface TOTableViewTool : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<TOBaseSection *> *sectionArray;

@property (nonatomic, weak) id<UIScrollViewDelegate> delegate;

@end
