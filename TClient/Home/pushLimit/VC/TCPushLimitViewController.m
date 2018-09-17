//
//  TCPushLimitViewController.m
//  TClient
//
//  Created by mark_zhang on 2018/9/17.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCPushLimitViewController.h"
#import "WMMenuView.h"
@interface TCPushLimitViewController ()<WMMenuViewDelegate,WMMenuViewDataSource>
@property ( nonatomic,strong) IBOutlet WMMenuView *menuItemView;
@property (weak, nonatomic) IBOutlet UIView *menuBgView;

@end

@implementation TCPushLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布解封";
    [self setupSubview];
}

- (void)setupSubview {
    
    self.menuItemView = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40.f)];
    self.menuItemView.progressViewIsNaughty = YES;
    self.menuItemView.lineColor = kThemeColor;
    self.menuItemView.delegate = self;
    self.menuItemView.dataSource = self;
    self.menuItemView.layoutMode = WMMenuViewLayoutModeLeft;
    self.menuItemView.progressWidths = @[@(kScreenWidth/2),@(kScreenWidth/2)];
    self.menuItemView.style = WMMenuViewStyleLine;
    [self.menuBgView addSubview:self.menuItemView];
   
}

- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu {
    
    return 2;
}
- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index {
    
    return index == 0 ? @"非好友解封填资料" : @"非好友解封不填资料";
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state {
    UIColor *color = [UIColor colorWithHexString:@"#333333"];
    if (state == WMMenuItemStateNormal) {
        color = [color colorWithAlphaComponent:0.5f];
    }
    return color;
}

- (CGFloat)menuView:(WMMenuView *)menu titleSizeForState:(WMMenuItemState)state {
    if (state == WMMenuItemStateNormal) {
        return 14.f;
    }
    return 17.f;
}

- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index {
    return 0.f;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    return kScreenWidth/2.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
