//
//  TCChangePwdViewController.m
//  TClient
//
//  Created by Mark on 2018/9/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCChangePwdViewController.h"

@interface TCChangePwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTxt;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@property (weak, nonatomic) IBOutlet UITextField *surePwdTxt;
@property (weak, nonatomic) IBOutlet UIButton *sendAuthCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@end

@implementation TCChangePwdViewController
{
    
    dispatch_source_t _timer;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - setupUI

- (void)setupUI {
    
   NSString *titleInfo =  self.changePwdType == TChangePwdOfFind?@"找回密码":@"修改密码";
    self.title = titleInfo;
    [self.sureBtn setTitle:titleInfo forState:UIControlStateNormal];
    [self setupDyCodeButtonReady];
    
    TCUserInfoModel *userInfoModel  = [TCUserManger shareUserManger].userModel;
    if (!userInfoModel) {
        return;
    }
    self.userNameTxt.text = kUnNilStr(userInfoModel.mobile);
}

#pragma mark - privateFunc

- (void)startTime {
    
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    WEAK_REF(self);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            [weak_self releaseTimer];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                [weak_self.sendAuthCodeBtn setTitle:@"获取动态码" forState:UIControlStateNormal];
                [weak_self setupDyCodeButtonReady];
            });
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds == 0 ? 60 : seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [weak_self.sendAuthCodeBtn setTitle:[NSString stringWithFormat:@"已发(%@s)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                [weak_self setupDyCodeButtonWait];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)releaseTimer {
    
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
}

- (void)setupDyCodeButtonReady {
    self.sendAuthCodeBtn.userInteractionEnabled = YES;
    self.sendAuthCodeBtn.layer.cornerRadius = 4.0f;
    self.sendAuthCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
    self.sendAuthCodeBtn.layer.borderWidth = 1.0f;
    [self.sendAuthCodeBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.sendAuthCodeBtn setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupDyCodeButtonWait {
    self.sendAuthCodeBtn.userInteractionEnabled = NO;
    self.sendAuthCodeBtn.layer.cornerRadius = 4.0f;
    self.sendAuthCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    self.sendAuthCodeBtn.layer.borderWidth = 1.0f;
    [self.sendAuthCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendAuthCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
    
}

#pragma mark - requestFunc

- (void)requestSendCode {
    
    [MBProgressHUD showMessage:@"正在加载..."];
    [THTTPRequestTool postRequestDataWithUrl:@"api/sms/send" par:@{@"data":@{@"mobile":kUnNilStr(self.userNameTxt.text),@"event":@"resetpwd"}} finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"发送成功"];
            [self startTime];
        } else {
            [MBProgressHUD showError:response.msg];
        }
    }];
}

- (void)requestChangePwd {
    
    [MBProgressHUD showMessage:@"正在加载..."];
    NSDictionary *par = @{@"mobile":kUnNilStr(self.userNameTxt.text),@"password":kUnNilStr(self.pwdTxt.text),@"password_confirm":kUnNilStr(self.surePwdTxt.text),@"captcha":kUnNilStr(self.authCodeTxt.text)};
    
    [THTTPRequestTool postRequestDataWithUrl:@"api/user/resetpwd" par:@{@"data":par} finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:[self.title stringByAppendingString:@"成功"]];
            [self navBackAction];
        } else {
            [MBProgressHUD showError:response.msg];
        }
    }];
}

#pragma mark - actionFunc

- (IBAction)actionSure:(id)sender {
    
    [self.view endEditing:YES];
    NSString *errorMsg;
    if (self.userNameTxt.text.length == 0) {
        errorMsg = @"账号不能为空";
    } else if (self.authCodeTxt.text == 0) {
        errorMsg = @"验证码不能为空";
    } else if (self.pwdTxt.text.length == 0) {
        errorMsg = @"密码不能为空";
    } else if (![self.pwdTxt.text isEqualToString:self.surePwdTxt.text]) {
        errorMsg = @"两次输入密码不一致";
    }
    if (errorMsg.length > 0) {
        [MBProgressHUD showError:errorMsg];
        return;
    }
    [self requestChangePwd];
}

- (IBAction)actionSendAuthCode:(id)sender {
    
    [self.view endEditing:YES];
    if (self.userNameTxt.text.length > 0) {
        [self requestSendCode];
    } else {
        [MBProgressHUD showError:@"请输入手机号码"];
    }
}

- (void)dealloc {
    
    NSLog(@" %@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [self releaseTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
