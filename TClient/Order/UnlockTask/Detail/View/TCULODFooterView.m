//
//  TCULODFooterView.m
//  TClient
//
//  Created by mark_zhang on 2018/11/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCULODFooterView.h"

@implementation TCULODFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    [T2TView setRoundCornerFor:self.okBtn radiu:20.f];
}

- (IBAction)actionOkBtn:(id)sender {
    
    !self.actionOkBlock?:self.actionOkBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
