//
//  TCLoginViewController.m
//  TClient
//
//  Created by Mark on 2018/8/24.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCLoginViewController.h"
#import "TCRegisterViewController.h"
#import "TCChangePwdViewController.h"
#import "T2TView.h"
@interface TCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTxt;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation TCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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

#pragma mark - setupUI

- (void)setupUI {
    
    self.mobileTxt.text = [kUserDefaults objectForKey:TLogin_Mobile_saveKey];
    self.pwdTxt.text = [kUserDefaults objectForKey:TLogin_pwd_saveKey];
    [T2TView setRoundCornerFor:self.loginBtn radiu:20.f];
}

#pragma mark - privateFunc

- (void)requestLogin {
    
    [MBProgressHUD showMessage:@"正在登录..."];
    NSDictionary *par = @{@"mobile":kUnNilStr(self.mobileTxt.text),@"password":kUnNilStr(self.pwdTxt.text),@"type":@(1)};
    [THTTPRequestTool postRequestDataWithUrl:@"api/user/login" par:@{@"data":par} finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD hideHUD];
            [[TCUserManger shareUserManger] loginSuccessReloadWithUserInfo:response.data[@"userinfo"] mobile:self.mobileTxt.text pwd:self.pwdTxt.text];
            !self.loginSuccessBlock?:self.loginSuccessBlock();
        } else {
            [MBProgressHUD showError:response.msg];
        }
    }];
}

#pragma mark - actionFunc
- (IBAction)actionRegiser:(id)sender {
    
    TCRegisterViewController *rvc = [[TCRegisterViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)actionLogin:(id)sender {
    
    [self.view endEditing:YES];
    if (self.mobileTxt.text.length == 0) {
        [MBProgressHUD showError:@"手机号不能为空"];
        return;
    } else if (self.pwdTxt.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    [self requestLogin];
}

- (IBAction)actionFindPwd:(id)sender {
  [self.view endEditing:YES];
    TCChangePwdViewController *findPwdVc = [[TCChangePwdViewController alloc] init];
    findPwdVc.changePwdType = TChangePwdOfFind;
    [self.navigationController pushViewController:findPwdVc animated:YES];
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
