//
//  TPopViewController.m
//  Examda
//
//  Created by Mark on 2017/4/20.
//  Copyright © 2017年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TPopViewController.h"

@interface TPopViewController ()

@end

@implementation TPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

#pragma mark - 禁止旋转


-(BOOL)shouldAutorotate
{
    
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
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
