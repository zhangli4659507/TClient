//
//  TCQRCodeRegisterVC.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCQRCodeRegisterVC.h"
#import "TCQRSection.h"
#import "TOTableViewTool.h"
#import "TCRegisterOrderListModel.h"
@interface TCQRCodeRegisterVC ()
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@property (nonatomic, strong) TCQRSection *section;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pgIndex;
@property (nonatomic, strong) NSMutableArray<TCRegisterOrderModel *> *dataArr;
@property (nonatomic, assign) BOOL isRequest;
@end

@implementation TCQRCodeRegisterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubview];
    [self layoutSubview];
    [self.tableView.mj_header beginRefreshing];
   
}

#pragma mark - setupSubview
- (void) setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self.tableViewTool;
    self.tableView.dataSource = self.tableViewTool;
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pushDownRefesh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushUpRefesh)];
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
    
    self.tableViewTool.sectionArray = @[self.section];
}

#pragma mark - layoutSubview

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - setupData

- (void)pushDownRefesh {
    
    if(self.isRequest) return;
    self.pgIndex = 1;
    self.dataArr = @[].mutableCopy;
    [self requestData];
}

- (void)pushUpRefesh {
    
     if(self.isRequest) return;
    self.pgIndex ++;
    [self requestData];
}

- (void)requestData {
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"page":@(self.pgIndex)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"page":@(self.pgIndex)};
    [THTTPRequestTool getSignRequestDataWithUrl:@"api/xiadan/order/get_order_register_list" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        self.isRequest = NO;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            TCRegisterOrderListModel *listModel = [TCRegisterOrderListModel mj_objectWithKeyValues:response.data];
            [self setupDataWithListModel:listModel];
        } else {
            self.tableView.mj_footer.hidden = YES;
            [MBProgressHUD showError:response.msg];
        }
    }];
    
}


- (void)setupDataWithListModel:(TCRegisterOrderListModel *)listModel {
    
    [self.dataArr addObjectsFromArray:listModel.list];
    self.tableView.mj_footer.hidden = listModel.page_index >= listModel.total_page;
    self.section.dataSource = self.dataArr;
    [self.tableView reloadData];
}

#pragma mark - getter

- (TOTableViewTool *)tableViewTool {
    
    if (_tableViewTool == nil) {
        _tableViewTool = [[TOTableViewTool alloc] init];
    }
    return _tableViewTool;
}

- (TCQRSection *)section {
    
    if (_section == nil) {
        _section = [[TCQRSection alloc] init];
        [_section tableViewRegisterView:self.tableView];
    }
    return _section;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
