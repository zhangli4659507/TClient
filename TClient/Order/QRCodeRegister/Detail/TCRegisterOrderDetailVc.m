//
//  TCRegisterOrderDetailVc.m
//  TClient
//
//  Created by mark_zhang on 2018/11/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCRegisterOrderDetailVc.h"
#import "TCRegisterOrderDetailModel.h"
#import "TCOrderComplaintVC.h"
@interface TCRegisterOrderDetailVc ()
@property (weak, nonatomic) IBOutlet UILabel *orderSignLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *peopleNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *giveUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *failBtnn;
@property (nonatomic, strong) TCRegisterOrderDetailModel *orderModel;

@end

@implementation TCRegisterOrderDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [T2TView setRoundCornerFor:self.okBtn radiu:20.f];
    [self requestDetailModel];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI {
    
    self.orderSignLbl.text = self.orderModel.order_sn;
    self.orderStateLbl.text = self.orderModel.status_text;
    self.timeLbl.text = self.orderModel.add_time;
    self.peopleNameLbl.text = kUnNilStr(self.orderModel.nickname);
    self.priceLbl.text = [NSString stringWithFormat:@"%@元",self.orderModel.order_price];
    self.failBtnn.hidden =  !(self.orderModel.status == 2 || self.orderModel.status == 4 || self.orderModel.status == 6);
    self.giveUpBtn.hidden = self.orderModel.status != 1;
    self.okBtn.hidden = self.orderModel.status != 4;
    self.navigationItem.rightBarButtonItem = nil;
    if (self.orderModel.status == 3 || self.orderModel.status == 6) {
        [self addComplaintRightItem];
    }
}

- (IBAction)actionFailBtn:(id)sender {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"order_id":@(self.order_id)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(self.order_id)};
    [MBProgressHUD showMessage:@"正在处理"];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/register_order_fail" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"操作成功"];
            !self.refreshBlock?:self.refreshBlock();
            [self navBackAction];
        } else {
            [MBProgressHUD showError:kUnNilStr(response.msg)];
        };
    }];
    
}

- (IBAction)actionGiveupBtn:(id)sender {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"order_id":@(self.order_id)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(self.order_id)};
    [MBProgressHUD showMessage:@"正在处理"];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/register_give_up" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"操作成功"];
            !self.refreshBlock?:self.refreshBlock();
            [self navBackAction];
        } else {
            [MBProgressHUD showError:kUnNilStr(response.msg)];
        };
    }];
    
}

- (IBAction)actionOkBtn:(id)sender {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"order_id":@(self.order_id)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(self.order_id)};
    [MBProgressHUD showMessage:@"正在处理"];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/register_order_finish" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"操作成功"];
            !self.refreshBlock?:self.refreshBlock();
            [self navBackAction];
        } else {
            [MBProgressHUD showError:kUnNilStr(response.msg)];
        };
    }];
    
}

- (void)addComplaintRightItem {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"投诉" titleColor:[UIColor whiteColor] target:self action:@selector(routerComplaint)];
    
}

- (void)routerComplaint {
    TCOrderComplaintVC *cvc = [[TCOrderComplaintVC alloc] init];
    cvc.order_id = self.order_id;
    cvc.complaintType = TCOrderComplaintRegister;
    WEAK_REF(self);
    [cvc setComplaintSuccessBlock:^{
        [weak_self requestDetailModel];
    }];
    [self.navigationController pushViewController:cvc animated:YES];
    
}


- (void)requestDetailModel {
    
    [TLodingHub setGifOnView:self.view withTitle:@"正在加载...."];
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"order_id":@(self.order_id)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(self.order_id)};
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    self.navigationItem.rightBarButtonItem = nil;
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/register_order_detail" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        [TLodingHub hideAllHUDsForView:self.view];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            self.orderModel = [TCRegisterOrderDetailModel mj_objectWithKeyValues:response.data];
            [self setupUI];
        } else {
            
            WEAK_REF(self);
            [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
                [weak_self requestDetailModel];
            }];
        }
    }];
    
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
