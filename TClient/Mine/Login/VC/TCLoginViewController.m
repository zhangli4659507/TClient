//
//  TCLoginViewController.m
//  TClient
//
//  Created by Mark on 2018/8/24.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCLoginViewController.h"
#import "TCRegisterViewController.h"
@interface TCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTxt;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@end

@implementation TCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - actionFunc
- (IBAction)actionRegiser:(id)sender {
    TCRegisterViewController *rvc = [[TCRegisterViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)actionLogin:(id)sender {
    
}

- (IBAction)actionFindPwd:(id)sender {
    
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
