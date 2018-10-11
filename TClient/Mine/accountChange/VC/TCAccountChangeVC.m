//
//  TCAccountChangeVC.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCAccountChangeVC.h"
#import "TCAccountChangeSection.h"
#import "TOTableViewTool.h"
#import "TCAccountChangeModel.h"
@interface TCAccountChangeVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, assign) BOOL isRequest;
@end

@implementation TCAccountChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户变动";
    [self setupSubview];
    [self layoutSubview];
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

#pragma mark - setupSubview

- (void)setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self.tableViewTool;
    self.tableView.dataSource = self.tableViewTool;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.tableView.mj_footer.hidden = YES;
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
    self.dataSource = @[].mutableCopy;
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
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/account/transaction_list" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        [TLodingHub hideAllHUDsForView:self.view];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        TCAccountChangeModel *model;
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            model = [TCAccountChangeModel mj_objectWithKeyValues:response.data];
        }
        [self setupDataWithModel:model];
    }];
    
}

#pragma mark - setupData

- (void)setupDataWithModel:(TCAccountChangeModel *)model {
    
    if ([model isKindOfClass:[TCAccountChangeModel class]]) {
        [self.dataSource addObjectsFromArray:model.list];
    }
    
    TCAccountChangeSection *section = [[TCAccountChangeSection alloc] init];
    [section tableViewRegisterView:self.tableView];
    section.dataSource = self.dataSource;
    self.tableViewTool.sectionArray = @[section];
    [self.tableView reloadData];
    self.tableView.mj_footer.hidden = self.pageIndex >= model.total_pages;
    if (self.dataSource.count == 0) {
        WEAK_REF(self);
        [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
            [weak_self.tableView.mj_header beginRefreshing];
        }];
    }
    
}

#pragma mark - getter

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
