//
//  TNUHeadBgView.m
//  Examda
//
//  Created by liqi on 17/6/8.
//  Copyright © 2017年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TNUHeadBgView.h"

#import "NSString+MD5.h"
#import "UIImage+TUtil.h"
@interface TNUHeadBgView ()



@end

@implementation TNUHeadBgView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImgView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imgView.frame = self.bounds;
}

- (void)setupImgView
{
   
    self.imgView.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#e13b29"]];
    
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
    }
    return _imgView;
}


@end
