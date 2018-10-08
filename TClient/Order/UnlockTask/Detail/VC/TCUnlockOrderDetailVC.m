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
@end

@implementation TCUnlockOrderDetailVC

- (void)viewDidLoad {
    
    self.title = @"订单详情";
    [super viewDidLoad];
    [self setupSubview];
    [self layoutSubview];
    [self setupData];
    [self setupUI];
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
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableHeaderView = tableHeaderView;
    
}

- (void)setupUI {
    self.tableHeaderView.orderNumLbl.text = [NSString stringWithFormat:@"订单号：%@",self.orderModel.order_sn];
    
    self.tableHeaderView.platFormPriceLbl.text = [NSString stringWithFormat:@"平台服务费：%@元",self.orderModel.service_price];
    self.tableHeaderView.bondPriceLbl.text = [NSString stringWithFormat:@"保费：%@元",self.orderModel.bond_price];
    self.tableHeaderView.unlockPriceLbl.text = [NSString stringWithFormat:@"解封费：%@元",self.orderModel.order_price];
    self.tableHeaderView.stateLbl.text = self.orderModel.status_text;
    if (self.orderModel.type != 1) {
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

#pragma mark - setupData

- (void)setupData {
    
    TCULODSection *section = [[TCULODSection alloc] init];
    [section tableViewRegisterView:self.tableView];
    section.dataSource = self.orderModel.jd_user_list;
    self.tableViewTool.sectionArray = @[section];
    [self.tableView reloadData];
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
