//
//  TCCommonSenseVC.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCCommonSenseVC.h"
#import "TCCommonSenseModel.h"
#import "TCCommonSenseSection.h"
#import "TOTableViewTool.h"

@interface TCCommonSenseVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@property (nonatomic, strong) TCCommonSenseSection *section;
@property (nonatomic, strong) NSMutableArray<TCCommonSenseModel *> *arrData;
@property (nonatomic, assign) NSUInteger pgIndex;
@property (nonatomic, assign) BOOL isRequest;
@end

@implementation TCCommonSenseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告";
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
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefrsh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullMoreData)];
    self.tableView.mj_footer.hidden = YES;
    
}

#pragma mark - layoutSubview

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
}

#pragma mark -privateFunc

- (void)pullDownRefrsh {
    if(self.isRequest) return;
    self.pgIndex = 1;
    self.arrData = @[].mutableCopy;
    [self requestData];
}

- (void)pullMoreData {
    if(self.isRequest) return;
    self.pgIndex += 1;
    [self requestData];
}

#pragma mark - requestData

- (void)requestData {
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [parInfoDic setObject:@{@"page":@(self.pgIndex)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"page":@(self.pgIndex)}];
    if (self.pgIndex == 1) {
         [TLodingHub setGifOnView:self.view withTitle:@"正在加载...."];
    }
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/announce/announce_list" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        TCCommonSenseListModel *listModel;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [TLodingHub hideAllHUDsForView:self.view];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            listModel = [TCCommonSenseListModel mj_objectWithKeyValues:response.data] ;
        }
        [self setupDataWithListModel:listModel];
    }];
    
}

- (void)setupDataWithListModel:(TCCommonSenseListModel *)listModel {
    if ([listModel isKindOfClass:[TCCommonSenseListModel class]]) {
        [self.arrData addObjectsFromArray:listModel.list];
    }
    [self.section tableViewRegisterView:self.tableView];
    self.section.dataSource = self.arrData;
    [self.tableView reloadData];
    self.tableView.mj_footer.hidden = listModel.total_pages == self.pgIndex;
    if (self.arrData.count == 0) {
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
        _tableViewTool.sectionArray = @[self.section];
    }
    return _tableViewTool;
}

- (TCCommonSenseSection *)section {
    
    if (_section == nil) {
        _section = [[TCCommonSenseSection alloc] init];
    }
    return _section;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
