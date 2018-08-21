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
@interface TCQRCodeRegisterVC ()
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TCQRCodeRegisterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubview];
    [self layoutSubview];
    [self setupData];
}

#pragma mark - setupSubview
- (void) setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self.tableViewTool;
    self.tableView.dataSource = self.tableViewTool;
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
}

#pragma mark - layoutSubview

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - setupData

- (void)setupData {
    
    TCQRSection *qrsection = [[TCQRSection alloc] init];
    [qrsection tableViewRegisterView:self.tableView];
    qrsection.dataSource = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    self.tableViewTool.sectionArray = @[qrsection];
    [self.tableView reloadData];
    
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

@end
