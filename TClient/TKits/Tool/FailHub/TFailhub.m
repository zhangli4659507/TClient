//
//  TFailhub.m
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TFailhub.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
@implementation TFailhub

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [T2TView setRoundCornerFor:self.reloadBtn radiu:15.f];
}

+ (TFailhub *)showFailHubWithSuperView:(UIView *)superView  reloadBlock:(void(^)(void))reloadBlock{
    return [self showFailHubWithSuperView:superView edg:UIEdgeInsetsZero reloadBlock:reloadBlock];
}
+ (TFailhub *)showFailHubWithSuperView:(UIView *)superView  edg:(UIEdgeInsets)edg reloadBlock:(void(^)(void))reloadBlock {
    
    TFailhub *hub = [TFailhub loadInstanceFromNib];
    hub.reloadBlock = reloadBlock;
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    hub.reloadBtn.hidden = reachabilityManager.reachable;

    if (superView) {
        [superView addSubview:hub];
        [hub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView).insets(edg);
        }];
    }
    return hub;
}

+ (void)hidenALLFailhubWithSuperView:(UIView *)superView {
    
    NSArray *subviews = superView.subviews;
    Class hudClass = [TFailhub class];
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:hudClass]) {
            aView.hidden = YES;
            [aView removeFromSuperview];
        }
    }
}

#pragma mark - actionFunc
- (IBAction)actionReloadBtn:(id)sender {
    
    (!self.reloadBlock)?:self.reloadBlock();
}

@end
