//
//  TCRegisterViewController.m
//  TClient
//
//  Created by mark_zhang on 2018/8/23.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCRegisterViewController.h"

@interface TCRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTxt;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@property (weak, nonatomic) IBOutlet UITextField *surePwdTxt;
@property (weak, nonatomic) IBOutlet UITextField *referralCodeTxt;
@property (weak, nonatomic) IBOutlet UIButton *agreeProtolBtn;
@property (weak, nonatomic) IBOutlet UIButton *protolBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendAuthCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *backLoginBtn;
@end

@implementation TCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - actionFunc

- (IBAction)actionSendAuthCode:(id)sender {
}
- (IBAction)actionAgreeProtolBtn:(id)sender {
}
- (IBAction)actionRegisterProtocol:(id)sender {
}

- (IBAction)actionRegisterBtn:(id)sender {
}
- (IBAction)actionBackLoginBtn:(id)sender {
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
