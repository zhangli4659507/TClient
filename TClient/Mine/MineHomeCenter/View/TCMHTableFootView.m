//
//  TCMHTableFootView.m
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TCMHTableFootView.h"
#import "T2TView.h"
@implementation TCMHTableFootView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [T2TView setRoundCornerFor:self.loginOutBtn radiu:15.0f];
}

- (IBAction)actionLoginout:(id)sender {
    !_actionLoginOut?:_actionLoginOut();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
