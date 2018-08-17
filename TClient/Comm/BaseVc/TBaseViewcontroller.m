//
//  TBaseViewcontroller.m
//  TClient
//
//  Created by Mark on 2018/8/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TBaseViewcontroller.h"
#import "UIImage+TUtil.h"
@interface TBaseViewcontroller ()

@end

@implementation TBaseViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavBar];
    
}

- (void)configNavBar {
    NSDictionary* attrs = @{NSForegroundColorAttributeName:
                                [UIColor whiteColor],
                            NSFontAttributeName:
                                [UIFont systemFontOfSize:17.0],
                            };
    
    UIColor *bgColor = [UIColor colorWithHexString:@"#279AF9"];;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    [self.navigationController.navigationBar setTitleTextAttributes:attrs];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:bgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    NSString *backImgString =  @"btn_back_white";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithIcon:backImgString target:self action:@selector(navBackAction)];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)navBackAction {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if(self.navigationController) {
      
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
