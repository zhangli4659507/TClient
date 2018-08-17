//
//  TTabBarViewController.m
//  TServer
//
//  Created by Mark on 2018/8/17.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TTabBarViewController.h"
#import "UIImage+TUtil.h"
@implementation TTabbarConfig

- (instancetype)initWithTitle:(NSString *)title imaName:(NSString *)imaName imaSelectName:(NSString *)imaSelectName vc:(TNavViewController *)vc {
    
    if (self = [super init]) {
        _title = title;
        _imaName = imaName;
        _imaSelectName = imaSelectName;
        _vc = vc;
    }
    return self;
}

@end
@interface TTabBarViewController ()

@end

@implementation TTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithConfigArr:(NSArray<TTabbarConfig *> *)configArr {
    if (self = [super init]) {
        [self setUpVcsWithConfigArr:configArr];
    }
    return self;
}

- (void)setUpVcsWithConfigArr:(NSArray<TTabbarConfig *> *)configArr {
    
    UIImage *bgImg = [UIImage imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.9]];
    [self.tabBar setBackgroundImage:bgImg];
    
    
    [[UITabBarItem appearanceWhenContainedIn:[TTabBarViewController class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#555555"]
                                                                                                           } forState:UIControlStateNormal];
    
    [[UITabBarItem appearanceWhenContainedIn:[TTabBarViewController class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#e13b29"]
                                                                                                           } forState:UIControlStateSelected];
    
    self.tabBar.translucent = NO;
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    NSMutableArray *arrVc = [NSMutableArray array];
    for (TTabbarConfig *config in configArr) {
        [arrVc addObject:config.vc];
        config.vc.tabBarItem = [self tabBarItem:config.title image:config.imaName selectedImage:config.imaSelectName];
    }
    
    self.viewControllers = [arrVc copy];
}

- (UITabBarItem *)tabBarItem:(NSString *)title image:(NSString *)imgName selectedImage:(NSString *)selectedImage
{
    UIImage *sImage = [UIImage imageNamed:selectedImage];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imgName] selectedImage:[sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    if([[UIDevice currentDevice].model hasPrefix:@"iPhone"]){
        item.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return item;
}

- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
