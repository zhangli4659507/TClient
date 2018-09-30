//
//  TCULODHeaderView.m
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCULODHeaderView.h"

@implementation TCULODHeaderView

- (void)awakeFromNib {
    
 [super awakeFromNib];
 [T2TView setRoundCornerFor:self.unLockButton radiu:15.f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
