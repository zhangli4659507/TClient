//
//  TCUnlockTaskVC.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnlockTaskVC.h"
#import "TCUnlockTaskListModel.h"
#import "TCUnlockListTableViewCell.h"
#import "TCUnlockTaskListSection.h"
#import "TOTableViewTool.h"
#import "TCUnlockOrderDetailVC.h"
@interface TCUnlockTaskVC ()
@property (nonatomic, assign) NSUInteger pgIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@property (nonatomic, strong) NSMutableArray<TCUnlockOrderModel *> *dataSource;
@property (nonatomic, strong) TCUnlockTaskListSection *section;
@property (nonatomic, assign) BOOL isRequest;
@end

@implementation TCUnlockTaskVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubview];
    [self layoutSubview];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - setupSubview

- (void)setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self.tableViewTool;
    self.tableView.dataSource = self.tableViewTool;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pushDownRefesh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushUpRefesh)];
    self.tableView.mj_footer.hidden = YES;
    
}

#pragma mark - privateFunc

- (void)pushDownRefesh {
    
    if(self.isRequest) return;
    self.pgIndex = 1;
    self.dataSource = [NSMutableArray array];
    [self requestData];
}

- (void)pushUpRefesh {
    
    if(self.isRequest) return;
    self.pgIndex ++;
    [self requestData];
}

#pragma mark - layoutSubview

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

#pragma mark - requestFunc

- (void)requestData {
    
    self.isRequest = YES;
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"page":@(self.pgIndex)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"page":@(self.pgIndex)};
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    if (self.pgIndex == 1) {
        [TLodingHub setGifOnView:self.view withTitle:@"正在加载..."];
    }
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/get_order_unseal_list" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        self.isRequest = NO;
        [TLodingHub hideAllHUDsForView:self.view];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            TCUnlockTaskListModel *listModel = [TCUnlockTaskListModel mj_objectWithKeyValues:response.data];
            [self setupDataWithListModel:listModel];
        } else {
            [MBProgressHUD showError:response.msg];
            self.tableView.mj_footer.hidden = self.pgIndex == 1;
        }
        if (self.dataSource.count == 0) {
            WEAK_REF(self);
            [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
                [weak_self.tableView.mj_header beginRefreshing];
            }];
        }
    }];
}

- (void)setupDataWithListModel:(TCUnlockTaskListModel *)listModel {
    
    [self.dataSource addObjectsFromArray:listModel.list];
    self.tableView.mj_footer.hidden = listModel.page_index >= listModel.total_page;
    self.section.dataSource = self.dataSource;
    WEAK_REF(self);
    [self.section setDidSelectedBlock:^(TCUnlockOrderModel *model) {
        TCUnlockOrderDetailVC *dvc = [[TCUnlockOrderDetailVC alloc] init];
        dvc.orderModel = model;
        [weak_self.navigationController pushViewController:dvc animated:YES];
    }];
    [self.tableView reloadData];
}

#pragma mark - getterFunc

- (TOTableViewTool *)tableViewTool {
    
    if (_tableViewTool == nil) {
        _tableViewTool = [[TOTableViewTool alloc] init];
        _tableViewTool.sectionArray = @[self.section];
    }
    return _tableViewTool;
}

- (TCUnlockTaskListSection *)section {
    
    if (_section == nil) {
        _section = [[TCUnlockTaskListSection alloc] init];
        [_section tableViewRegisterView:self.tableView];
    }
    return _section;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
