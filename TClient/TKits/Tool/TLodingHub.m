//
//  TLodingHub.m
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TLodingHub.h"
#import "FLAnimatedImage.h"
@implementation TLodingHub

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loding" withExtension:@"gif"];
    FLAnimatedImage *animatedImg = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
    self.gifView.animatedImage = animatedImg;
}

+ (TLodingHub *)setGifOnView:(UIView *)view withTitle:(NSString *)title {
    
    return [self setGifOnView:view withTitle:title edg:UIEdgeInsetsZero];
}

+ (TLodingHub *)setGifOnView:(UIView *)view withTitle:(NSString *)title edg:(UIEdgeInsets)edg {
    TLodingHub *hub = [TLodingHub loadInstanceFromNib];
    if (view) {
        [view addSubview:hub];
        [hub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view).insets(edg);
        }];
    }
    
    if (title.length > 0) {
        hub.lodingLbl.text = title;
    }
    return hub;
}

+ (void)hideAllHUDsForView:(UIView *)view
{
    NSArray *subviews = view.subviews;
    Class hudClass = [TLodingHub class];
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:hudClass]) {
            aView.hidden = YES;
            [aView removeFromSuperview];
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
