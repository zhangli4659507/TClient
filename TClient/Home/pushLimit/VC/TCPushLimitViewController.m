//
//  TCPushLimitViewController.m
//  TClient
//
//  Created by mark_zhang on 2018/9/17.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCPushLimitViewController.h"
#import "WMMenuView.h"
#import "TCPushLimitInfoModel.h"
#import "TCSelectAreaView.h"
#import "TCShowUnsealPriceView.h"
@interface TCPushLimitViewController ()
@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UITextField *wxText;
@property (weak, nonatomic) IBOutlet UITextField *mobileTxt;
@property (weak, nonatomic) IBOutlet UIButton *insuranceBtn;
@property (weak, nonatomic) IBOutlet UIButton *noInsuranceBtn;
@property (weak, nonatomic) IBOutlet UITextField *remarksTxt;
@property (weak, nonatomic) IBOutlet UILabel *insuranceLbl;
@property (weak, nonatomic) IBOutlet UILabel *serviceMoneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *commissionLbl;
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
@property (weak, nonatomic) IBOutlet UILabel *alertInfoLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *insuranceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *insuranceSpace;
@property (weak, nonatomic) IBOutlet UILabel *unsealPriceLbl;
@property (nonatomic, strong) TCPushLimitInfoModel *limitInfoModel;
@property (nonatomic, assign) CGFloat unselPrice;//解封佣金
@property (nonatomic, assign) NSInteger insuranceType;//保费类型 1-需要保费 2-无需保费
@property (nonatomic, strong) TAreaModel *selectAreaModel;//所选地区 为空表示不限地区
@end

@implementation TCPushLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布解封";
    [self requestLimitInfoData];
}

- (void)setupSubview {
    self.insuranceType = 1;
    self.insuranceBtn.selected = YES;
    self.noInsuranceBtn.selected = NO;
    self.alertInfoLbl.text = [NSString stringWithFormat:@"注意事项：%@",self.limitInfoModel.describe];
    self.serviceMoneyLbl.text = [NSString stringWithFormat:@"%.2lf元",self.limitInfoModel.service_price];
    self.insuranceLbl.text = [NSString stringWithFormat:@"%.2lf元",self.limitInfoModel.bond_price];
    self.commissionLbl.text = [NSString stringWithFormat:@"%.2lf - %.2lf元",self.limitInfoModel.bond_section_begin_price,self.limitInfoModel.bond_section_end_price];
    [T2TView setRoundCornerFor:self.pushBtn radiu:20.f];
   
}

#pragma mark - requestFunc

- (void)requestLimitInfoData {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
   
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [TLodingHub setGifOnView:self.view withTitle:@"正在加载...."];
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/order_unseal_data" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        [TLodingHub hideAllHUDsForView:self.view];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            
            self.limitInfoModel = [TCPushLimitInfoModel mj_objectWithKeyValues:response.data];
            [self setupSubview];
        } else {
            WEAK_REF(self);
            [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
                [weak_self requestLimitInfoData];
            }];
        }
    }];
    
}

- (void)requestPostLimit {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    
    NSMutableDictionary *dataDicInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:kUnNilStr([self.wxText.text trimSpace]),@"unseal_wx",@(self.insuranceType),@"type",@(self.unselPrice),@"unseal_price",nil];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"unseal_wx":kUnNilStr([self.wxText.text trimSpace]),@"type":@(self.insuranceType),@"unseal_price":@(self.unselPrice)}];
    
    if ([self.mobileTxt.text trimSpace].length > 0) {
        [dataDicInfo setObject:[self.mobileTxt.text trimSpace] forKey:@"unseal_phone"];
        [signDicInfo setObject:[self.mobileTxt.text trimSpace] forKey:@"unseal_phone"];
    }
    if (self.selectAreaModel) {
        [dataDicInfo setObject:@(self.selectAreaModel.areaId) forKey:@"province_id"];
        [signDicInfo setObject:@(self.selectAreaModel.areaId) forKey:@"province_id"];
    }
    if (self.remarksTxt.text.length > 0) {
        [dataDicInfo setObject:kUnNilStr(self.remarksTxt.text) forKey:@"remark"];
        [signDicInfo setObject:kUnNilStr(self.remarksTxt.text) forKey:@"remark"];
    }
    [parInfoDic setObject:dataDicInfo forKey:@"data"];
    [MBProgressHUD showMessage:@"正在上传...."];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/create_order_unseal" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"下单成功"];
            [self performSelector:@selector(navBackAction) withObject:nil afterDelay:2];
        } else {
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",response.msg]];
        }
    }];
}

#pragma mark - actionFunc

- (IBAction)actionSelectMoney:(id)sender {
    [TCShowUnsealPriceView showUnsealPriceViewWithUnsealPriceArr:self.limitInfoModel.unseal_price selectBlock:^(CGFloat unsealPrice) {
        self.unselPrice = unsealPrice;
        self.unsealPriceLbl.text = [NSString stringWithFormat:@"%.0lf元",unsealPrice];
    }];
    
}
- (IBAction)actionPushLimit:(id)sender {
    
    [self.view endEditing:YES];
    if ([self.wxText.text trimSpace].length == 0) {
        [MBProgressHUD showError: @"请输入正确微信号"];
        return;
    } else if (self.unselPrice == 0) {
        [MBProgressHUD showError: @"请先选择解封佣金"];
        return;
    }
    [self requestPostLimit];
    
}

- (IBAction)actionInsuranceBtn:(id)sender {
    
     [self.view endEditing:YES];
    self.insuranceBtn.selected = YES;
    self.noInsuranceBtn.selected = NO;
    self.insuranceHeight.constant = 17.f;
    self.insuranceSpace.constant = 15.f;
    self.insuranceType = 1;
}


- (IBAction)actionNoInsurance:(id)sender {
    
     [self.view endEditing:YES];
    self.insuranceBtn.selected = NO;
    self.noInsuranceBtn.selected = YES;
    self.insuranceHeight.constant = 0.f;
    self.insuranceSpace.constant = 0.f;
    self.insuranceType = 2;
}

- (IBAction)actionSelectArea:(id)sender {
    
    [self.view endEditing:YES];
    [TCSelectAreaView showAreaSlectedViewWithFinshSelectedBlock:^(TAreaModel *areaModel) {
        self.areaLbl.text = kUnNilStr(areaModel.name);
        self.selectAreaModel = areaModel;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
