//
//  TCRechargeViewController.m
//  TClient
//
//  Created by Mark on 2018/10/12.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCRechargeViewController.h"
#import "TCRechargeRecordVC.h"
#import <AlipaySDK/AlipaySDK.h>
@interface TCRechargeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTxt;
@property (weak, nonatomic) IBOutlet UILabel *balanceLbl;

@end

@implementation TCRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额充值";
    if ([TCUserManger shareUserManger].userModel) {
        self.balanceLbl.text = [NSString stringWithFormat:@"余额：%@元",[TCUserManger shareUserManger].userModel.money];
    }
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)actionAddMoney:(id)sender {
    [self.view endEditing:YES];
    
    if (self.moneyTxt.text.length == 0 || [self.moneyTxt.text floatValue] <= 0) {
        [MBProgressHUD showError:@"请输入正确的金额"];
        return;
    }
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [parInfoDic setObject:@{@"money":@(self.moneyTxt.text.floatValue)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"money":@(self.moneyTxt.text.floatValue)}];
    [MBProgressHUD showMessage:@"正在创建订单..."];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/recharge/create_recharge_order" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        if (response.code  == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            NSInteger orderId = [response.data[@"order_id"] integerValue];
            [self createApliPayWithOrderId:orderId];
        } else {
            [MBProgressHUD showError:response.msg];
        }
    }];
    
}

- (void)createApliPayWithOrderId:(NSInteger)orderID {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [parInfoDic setObject:@{@"order_id":@(orderID)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(orderID)}];
    [MBProgressHUD showMessage:@"正在创建订单..."];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/recharge/ali_app_pay" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        if (response.code  == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            [self alipayWithSignKey:response.data[@"sign_str"]];
            [MBProgressHUD hideHUD];
        } else {
            [MBProgressHUD showError:response.msg];
        }
    }];
}

- (void)alipayWithSignKey:(NSString *)key {
    
    [[AlipaySDK defaultService] payOrder:kUnNilStr(key) fromScheme:@"alipayTClient" callback:^(NSDictionary *resultDic) {
        if ([resultDic isKindOfClass:[NSDictionary class]] ) {
            EPayStateCode code = [resultDic[@"resultStatus"] integerValue];
            if (code == EPayStateSuccess) {
                CGFloat money =   [[TCUserManger shareUserManger].userModel.money floatValue];
                money += [self.moneyTxt.text floatValue];
                [TCUserManger shareUserManger].userModel.money = kStrWithFloat(money);
                [MBProgressHUD showSuccess:@"订单支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:TMoney_change_notiName object:nil];
            }
            else if (code == EPayStateFail) {
                [MBProgressHUD showError:@"订单支付失败"];
            }
            else if (code == EPayStateNetWorkError) {
                 [MBProgressHUD showError:@"网络连接错误"];
            }
            else if (code == EPayStateUserCancel) {
                [MBProgressHUD showError:@"您取消了支付~"];
            }
        }
        [self navBackAction];
    }];
}

- (IBAction)actionAddMoneyRecord:(id)sender {
    [self.view endEditing:YES];
    TCRechargeRecordVC *ivc = [[TCRechargeRecordVC alloc] init];
    [self.navigationController pushViewController:ivc animated:YES];
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
