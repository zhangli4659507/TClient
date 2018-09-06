//
//  TCUserInfoViewController.m
//  TClient
//
//  Created by Mark on 2018/9/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUserInfoViewController.h"
#import "TCSelectAreaView.h"
#import "T2TView.h"
#import "NSString+TDigest.h"
@interface TCUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *QQTxt;
@property (weak, nonatomic) IBOutlet UITextField *weChatTxt;
@property (weak, nonatomic) IBOutlet UITextField *realNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *aliPayTxt;
@property (weak, nonatomic) IBOutlet UITextField *localAreaTxt;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (nonatomic, strong) TAreaModel *selectAreaModel;

@end

@implementation TCUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
   
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - setupUI

- (void)setupUI {
    
     [T2TView setRoundCornerFor:self.editBtn radiu:20.f];
    TCUserInfoModel *userInfoModel = [TCUserManger shareUserManger].userModel;
    if (!userInfoModel) {
        return;
    }
    self.userNameTxt.text = kUnNilStr(userInfoModel.mobile);
    self.nickNameTxt.text = kUnNilStr(userInfoModel.nickname);
    self.QQTxt.text = kUnNilStr(userInfoModel.qq);
    self.weChatTxt.text = kUnNilStr(userInfoModel.wechat);
    self.realNameTxt.text = kUnNilStr(userInfoModel.realname);
    self.aliPayTxt.text = kUnNilStr(userInfoModel.alipay);
    self.localAreaTxt.text = kUnNilStr(userInfoModel.location);
}

#pragma mark -privateFunc

- (void)reloadUserInfoModel {
    
    TCUserInfoModel *userInfoModel = [TCUserManger shareUserManger].userModel;
    if (!userInfoModel) {
        return;
    }
    userInfoModel.nickname = kUnNilStr(self.nickNameTxt.text);
    userInfoModel.qq = kUnNilStr(self.QQTxt.text);
    userInfoModel.wechat = kUnNilStr(self.weChatTxt.text);
    userInfoModel.realname = kUnNilStr(self.realNameTxt.text);
    userInfoModel.alipay = kUnNilStr(self.aliPayTxt.text);
    userInfoModel.location = kUnNilStr(self.selectAreaModel.name);
}

#pragma mark -actionFunc

- (IBAction)actionSelectArea:(id)sender {
    
    [self.view endEditing:YES];
    [TCSelectAreaView showAreaSlectedViewWithFinshSelectedBlock:^(TAreaModel *areaModel) {
        self.localAreaTxt.text = kUnNilStr(areaModel.name);
        self.selectAreaModel = areaModel;
    }];
}

- (IBAction)actionEditBtn:(id)sender {
    NSString *errorMsg;
     if ([self.nickNameTxt.text trimSpace] == 0) {
        errorMsg = @"昵称不能为空";
    } else if ([self.QQTxt.text trimSpace] == 0) {
       errorMsg = @"QQ号不能为空";
    } else if ([self.weChatTxt.text trimSpace] == 0) {
        errorMsg = @"微信号不能为空";
    } else if ([self.realNameTxt.text trimSpace] == 0) {
        errorMsg = @"真是姓名不能为空";
    } else if ([self.aliPayTxt.text trimSpace] == 0) {
        errorMsg = @"支付宝账号不能为空";
    } else if (!self.selectAreaModel) {
         errorMsg = @"请选择归属地";
    }
    
    if (errorMsg.length != 0) {
        [MBProgressHUD showError:errorMsg];
        return;
    }
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    
    [parInfoDic setObject:@{@"id":@([TCUserManger shareUserManger].user_id),@"nickname":kUnNilStr(self.nickNameTxt.text),@"qq":kUnNilStr(self.QQTxt.text),@"wechat":kUnNilStr(self.weChatTxt.text),@"realname":kUnNilStr(self.realNameTxt.text),@"alipay":kUnNilStr(self.aliPayTxt.text),@"location":kUnNilStr(self.selectAreaModel.name),@"withdraw_type":@(1)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"id":@([TCUserManger shareUserManger].user_id),@"nickname":kUnNilStr(self.nickNameTxt.text),@"qq":kUnNilStr(self.QQTxt.text),@"wechat":kUnNilStr(self.weChatTxt.text),@"realname":kUnNilStr(self.realNameTxt.text),@"alipay":kUnNilStr(self.aliPayTxt.text),@"location":kUnNilStr(self.selectAreaModel.name),@"withdraw_type":@(1)}];

    [MBProgressHUD showMessage:@"正在加载...."];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/user/edit" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self reloadUserInfoModel];
            [self navBackAction];
        } else {
            [MBProgressHUD showError:response.msg];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
