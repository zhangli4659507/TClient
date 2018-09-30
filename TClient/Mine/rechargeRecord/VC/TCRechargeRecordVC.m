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
#import "TCReChargeRecordModel.h"
@interface TCRechargeRecordVC ()
@property (nonatomic, strong) TOTableViewTool *tableviewTool;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<TCReChargeRecordListModel *> *dataArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) BOOL isRequest;
@end

@implementation TCRechargeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值记录";
    [self setupSubview];
    [self layoutSubview];
    [self.tableView.mj_footer beginRefreshing];
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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

#pragma mark - layoutSubview

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

#pragma mark -  requestData

- (void)requestRefresh {
    
    if(self.isRequest) return;
    self.dataArray = @[].mutableCopy;
    self.pageIndex = 1;
    [self requestData];
    
}

- (void)requestMoreData {
    
    if(self.isRequest) return;
    self.pageIndex = self.pageIndex + 1;
    [self requestData];
}


- (void)requestData {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [parInfoDic setObject:@{@"page":@(self.pageIndex)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"page":@(self.pageIndex)}];
    if (self.pageIndex == 1) {
         [TLodingHub setGifOnView:self.view withTitle:nil];
    }
#warning 这里还未测试通过
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/service/recharge/recharge_list" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        [TLodingHub hideAllHUDsForView:self.view];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            TCReChargeRecordModel *model = [TCReChargeRecordModel mj_objectWithKeyValues:response.data];
            [self setupDataWithRechargeModel:model];
        }
        if (self.dataArray.count == 0) {
            WEAK_REF(self);
            [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
                [weak_self.tableView.mj_header beginRefreshing];
            }];
        }
    }];
}

#pragma mark - setupData

- (void)setupDataWithRechargeModel:(TCReChargeRecordModel *)rechargeModel {
    
    [self.dataArray addObjectsFromArray:rechargeModel.list];
    TCRechargeRecordSection *section = [[TCRechargeRecordSection alloc] init];
    [section tableViewRegisterView:self.tableView];
    section.dataSource = self.dataArray;
    
    self.tableviewTool.sectionArray = @[section];
    [self.tableView reloadData];
    self.tableView.mj_footer.hidden = self.dataArray.count == 0;
    
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
