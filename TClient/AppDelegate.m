//
//  AppDelegate.m
//  TClient
//
//  Created by Mark on 2018/8/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "AppDelegate.h"
#import "TBaseViewcontroller.h"
#import "TNavViewController.h"
#import "TCHomeViewController.h"
#import "TCOrderViewController.h"
#import "TCMineViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.clipsToBounds =YES;
    [self initTabbarVc];
    return YES;
}
- (void)initTabbarVc {
    TTabbarConfig *home = [[TTabbarConfig alloc] initWithTitle:@"首页" imaName:@"tab_icon_home_normal" imaSelectName:@"tab_icon_home_selected" vc:[[TNavViewController alloc] initWithRootViewController:[[TCHomeViewController alloc] init]]];
    TTabbarConfig *order = [[TTabbarConfig alloc] initWithTitle:@"订单" imaName:@"tab_icon_tk_normal" imaSelectName:@"tab_icon_tk_selected" vc:[[TNavViewController alloc] initWithRootViewController:[[TCOrderViewController alloc] init]]];
    TTabbarConfig *mine = [[TTabbarConfig alloc] initWithTitle:@"我的" imaName:@"tab_icon_grzx_normal" imaSelectName:@"tab_icon_grzx_selected" vc:[[TNavViewController alloc] initWithRootViewController:[[TCMineViewController alloc] init]]];
    
    self.tabBarVc = [[TTabBarViewController alloc] initWithConfigArr:@[home,order,mine]];
    self.window.rootViewController = self.tabBarVc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
