//
//  TCOrderViewController.m
//  TClient
//
//  Created by Mark on 2018/8/17.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCOrderViewController.h"
#import "WMPageController.h"
#import "TCUnlockTaskVC.h"
#import "TCQRCodeRegisterVC.h"
@interface TCOrderViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong) WMPageController *pageController;
@end

@implementation TCOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单";
    [self setupSubview];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.pageController.view.frame = self.view.bounds;
    self.pageController.viewFrame = self.view.bounds;
}

#pragma mark -

- (void)setupSubview {
    
    _pageController = [[WMPageController alloc] init];
    _pageController.menuViewStyle = WMMenuViewStyleLine;
    _pageController.delegate = self;
    _pageController.dataSource = self;
    _pageController.titleSizeNormal = 14.f;
    _pageController.titleSizeSelected = 17.f;
    _pageController.automaticallyCalculatesItemWidths = YES;
    _pageController.titleColorNormal = [UIColor colorWithHexString:@"#333"];
    _pageController.titleColorSelected = kThemeColor;
    _pageController.menuBGColor  = [UIColor whiteColor];
    _pageController.progressColor = kThemeColor;
    _pageController.menuHeight = 50.f;
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - wmDatasource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return 2;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    if (index == 0) {
        TCQRCodeRegisterVC *qvc = [[TCQRCodeRegisterVC alloc] init];
        return qvc;
    }
    TCUnlockTaskVC *uvc = [[TCUnlockTaskVC alloc] init];
    return uvc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return index == 0 ?@"二维码注册":@"解锁任务";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
