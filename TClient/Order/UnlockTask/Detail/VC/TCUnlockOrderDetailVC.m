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
@interface TCUnlockOrderDetailVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@end

@implementation TCUnlockOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubview];
    [self layoutSubview];
    // Do any additional setup after loading the view.
}

- (void)setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self.tableViewTool;
    self.tableView.dataSource = self.tableViewTool;
    [self.view addSubview:self.tableView];
}

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
