//
//  TCRechargeRecordVC.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCRechargeRecordVC.h"
#import "TCRechargeRecordSection.h"
#import "TOTableViewTool.h"
@interface TCRechargeRecordVC ()
@property (nonatomic, strong) TOTableViewTool *tableviewTool;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TCRechargeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值记录";
    [self setupSubview];
    [self layoutSubview];
    [self setupData];
    // Do any additional setup after loading the view.
}

#pragma mark - setupSubview

- (void)setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self.tableviewTool;
    self.tableView.dataSource = self.tableviewTool;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
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
    
    TCRechargeRecordSection *section = [[TCRechargeRecordSection alloc] init];
    [section tableViewRegisterView:self.tableView];
    section.dataSource = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    self.tableviewTool.sectionArray = @[section];
    [self.tableView reloadData];
    
}

#pragma mark - getter

- (TOTableViewTool *)tableviewTool {
    
    if (_tableviewTool == nil) {
        _tableviewTool = [[TOTableViewTool alloc] init];
    }
    return _tableviewTool;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
