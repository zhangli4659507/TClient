//
//  TCUnderMerchantVC.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnderMerchantVC.h"
#import "TCMyFriendSection.h"
#import "TOTableViewTool.h"
@interface TCUnderMerchantVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@end

@implementation TCUnderMerchantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下级号商";
    [self setupSubview];
    [self layoutSubview];
    [self setupData];
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
    
    TCMyFriendSection *section = [[TCMyFriendSection alloc] init];
    [section tableViewRegisterView:self.tableView];
    section.dataSource = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    self.tableViewTool.sectionArray = @[section];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
