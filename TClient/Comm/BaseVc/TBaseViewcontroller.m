//
//  TBaseViewcontroller.m
//  TClient
//
//  Created by Mark on 2018/8/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TBaseViewcontroller.h"

@interface TBaseViewcontroller ()

@end

@implementation TBaseViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configNavBar {
    
    
//    NSDictionary* attrs = @{NSForegroundColorAttributeName:
//                                [UIColor whiteColor],
//                            NSFontAttributeName:
//                                [UIFont systemFontOfSize:17.0],
//                            };
//    
//    UIColor *bgColor = kContentLightColor;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//
//    if (style == TNavBarLightStyle) {
//        attrs = @{NSForegroundColorAttributeName:
//                      RGB_1(51, 51, 51),
//                  NSFontAttributeName:
//                      [UIFont systemFontOfSize:17.0],
//                  };
//
//        bgColor = RGB_1(245, 245, 245);
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
//    }
//    [self.navigationController.navigationBar setTitleTextAttributes:attrs];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:bgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    NSString *backImgString = _navBarStyle == TNavBarRedStyle ? @"btn_back_white" : @"btn_back_red";
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithIcon:backImgString target:self action:@selector(navBackAction)];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)navBackAction {
    
    
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
