//
//  TCUnlockOrderDetailVC.m
//  TClient
//
//  Created by mark_zhang on 2018/9/26.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnlockOrderDetailVC.h"
#import "TCULODSection.h"
#import "TOTableViewTool.h"
#import "TCUnlockTaskListModel.h"
#import "TCULODHeaderView.h"
@interface TCUnlockOrderDetailVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@property (nonatomic, weak) TCULODHeaderView *tableHeaderView;
@property (nonatomic, strong) TCUnlockOrderModel *orderModel;
@end

@implementation TCUnlockOrderDetailVC

- (void)viewDidLoad {
    
    self.title = @"订单详情";
    [super viewDidLoad];
    [self setupSubview];
    [self layoutSubview];
    [self requetData];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    if (self.orderModel) {
        self.tableHeaderView.height = self.orderModel.type == 1 ? 140.f : 120.f;
    }
}


#pragma mark - setupsubview

- (void)setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self.tableViewTool;
    self.tableView.dataSource = self.tableViewTool;
    [self.view addSubview:self.tableView];
    
   TCULODHeaderView *tableHeaderView = [TCULODHeaderView loadInstanceFromNib];
    [tableHeaderView.unLockButton addTarget:self action:@selector(actionUnclok) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableHeaderView = tableHeaderView;
    
}

- (void)setupUI {
    
     self.tableHeaderView.height = self.orderModel.type == 1 ? 140.f : 120.f;
    
    self.tableHeaderView.orderNumLbl.text = [NSString stringWithFormat:@"订单号：%@",self.orderModel.order_sn];
    self.tableHeaderView.platFormPriceLbl.text = [NSString stringWithFormat:@"平台服务费：%@元",self.orderModel.service_price];
    self.tableHeaderView.bondPriceLbl.text = [NSString stringWithFormat:@"保费：%@元",self.orderModel.bond_price];
    self.tableHeaderView.unlockPriceLbl.text = [NSString stringWithFormat:@"解封费：%@元",self.orderModel.order_price];
    self.tableHeaderView.stateLbl.text = self.orderModel.status_text;
    if (self.orderModel.pay_status == 1) {//已缴纳解锁费用
        self.tableHeaderView.unLockButton.hidden = YES;
    }
    if (self.orderModel.type != 1) {//无保费订单
        self.tableHeaderView.boundPriceSpace.constant = 0.f;
        self.tableHeaderView.boundPriceHeight.constant = 0.f;
        self.tableHeaderView.bondPriceLbl.hidden = YES;
    }
}

#pragma mark - layoutSubview

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

#pragma mark - actionfunc

- (void)actionUnclok {
    
    [self requestUnlock];
    
    }


#pragma mark - setupData

- (void)setupData {
    
    TCULODSection *section = [[TCULODSection alloc] init];
    [section tableViewRegisterView:self.tableView];
    section.dataSource = self.orderModel.jd_user_list;
    WEAK_REF(self);
    [section setDidSelectedBlock:^(TCOrderUserInfoModel* userModel) {
        [weak_self requestUnlockWithUserInfoModel:userModel];
    }];
    self.tableViewTool.sectionArray = @[section];
    [self.tableView reloadData];
}

#pragma mark - requestFunc

- (void)requetData {
    
    [TLodingHub setGifOnView:self.view withTitle:@"正在加载...."];
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"order_id":@(self.order_id)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(self.order_id)};
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/order_unseal_detail" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        [TLodingHub hideAllHUDsForView:self.view];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            self.orderModel = [TCUnlockOrderModel mj_objectWithKeyValues:response.data];
            [self setupData];
            [self setupUI];
        } else {
            
            WEAK_REF(self);
            [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
                [weak_self requetData];
            }];
        }
    }];
}

- (void)requestUnlock {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"order_id":@(self.orderModel.order_id)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(self.orderModel.order_id)};
    [MBProgressHUD showMessage:@"正在处理..."];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/recharge/pay_unseal_order_price" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"处理成功"];
            self.orderModel.pay_status = 1;
            [self setupUI];
        } else {
            
            [MBProgressHUD showError:kUnNilStr(response.msg)];
        }
    }];
}

- (void)requestUnlockWithUserInfoModel:(TCOrderUserInfoModel *)userInfoModel {
    if (self.orderModel.pay_status ==  0) {
        [MBProgressHUD showAlert:@"请先缴纳解封费"];
        return;
    }
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"order_id":@(self.orderModel.order_id),@"jd_user_id":@(userInfoModel.recordId)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_id":@(self.orderModel.order_id),@"jd_user_id":@(userInfoModel.recordId)};
    [MBProgressHUD showMessage:@"正在处理..."];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/order_unseal_to_user" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:kUnNilStr(response.msg)];
            [self navBackAction];
        } else {
            
            [MBProgressHUD showError:kUnNilStr(response.msg)];
        }
    }];
}

#pragma mark - getterFunc

- (TOTableViewTool *)tableViewTool {
    
    if (_tableViewTool == nil) {
        _tableViewTool = [[TOTableViewTool alloc] init];
    }
    return _tableViewTool;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
