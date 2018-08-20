//
//  TCMineViewController.m
//  TClient
//
//  Created by Mark on 2018/8/17.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCMineViewController.h"
#import "TCMHTableFootView.h"
#import "TCMHCellConfigModel.h"
#import "TCMineHeaderSection.h"
#import "TCMHInfoSection.h"
#import "TOTableViewTool.h"
#import "TNUHeadBgView.h"
#import "UIImage+TUtil.h"
#import "TCAppDownloadViewController.h"
#import "TCChangePwdViewController.h"
#import "TCChangeAvoidViewController.h"
#import "TCUserInfoViewController.h"
#import "TCConnetServiceViewController.h"
#import "TCUserChangeViewController.h"
#import "TCMyFriendViewController.h"
#import "TCAcountSetViewController.h"
#import "TCInventFriendVC.h"

#define TMCHHeadViewHeight (152.f + kNavBarHeight)
@interface TCMineViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TOTableViewTool *tableViewTool;
@property (nonatomic, strong) TNUHeadBgView *headBgView;

@end

@implementation TCMineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpSubview];
    [self layoutSubview];
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - setupFunc

- (void)setUpSubview {
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self.tableViewTool;
    self.tableView.dataSource = self.tableViewTool;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self.view insertSubview:self.headBgView atIndex:0];
}

#pragma mark - layoutFunc

- (void)layoutSubview {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

- (void)addTableviewFootterView {
    
    TCMHTableFootView *footterView = [TCMHTableFootView loadInstanceFromNib];
    footterView.height = 150.f;
    self.tableView.tableFooterView = footterView;
    
}

#pragma mark - setupData

- (void)setupData {
    
    TCMineHeaderSection *section = [[TCMineHeaderSection alloc] init];
    [section tableViewRegisterView:self.tableView];
    section.dataSource = @[@1];

    TCMHInfoSection *secondSection = [[TCMHInfoSection alloc] init];
    [secondSection tableViewRegisterView:self.tableView];
    secondSection.dataSource = [self seccondSectionItems];
    
    TCMHInfoSection *thirdSection = [[TCMHInfoSection alloc] init];
    [thirdSection tableViewRegisterView:self.tableView];
    thirdSection.dataSource = [self thirdSectionItems];
    
    self.tableViewTool.sectionArray = @[section,secondSection,thirdSection];
    [self.tableView reloadData];
    
    
}

- (NSArray<TCMHCellConfigModel *> *)seccondSectionItems {
    
    TCMHInfoCellConfigModel *superiorItem = [[TCMHInfoCellConfigModel alloc] initWithHeadImaName:@"" title:@"我的上级" actionHandleBlock:^{

    }];
    superiorItem.info = @"12345567";
    
    TCMHBasicCellConfigModel *inventFriendItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"邀请好友" actionHandleBlock:^{
        TCInventFriendVC *ivc = [[TCInventFriendVC alloc] init];
        [self.navigationController pushViewController:ivc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *profitSetItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"利润设置" actionHandleBlock:^{
        TCAcountSetViewController *avc = [[TCAcountSetViewController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }];
    profitSetItem.rightInfo = @"已设置";
    
    TCMHBasicCellConfigModel *myFriendItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"我的伙伴" actionHandleBlock:^{
        TCMyFriendViewController *mvc = [[TCMyFriendViewController alloc] init];
        [self.navigationController pushViewController:mvc animated:YES];
    }];
    
    return @[superiorItem,inventFriendItem,profitSetItem,myFriendItem];
}

- (NSArray<TCMHCellConfigModel *> *)thirdSectionItems {
    TCMHBasicCellConfigModel *accountChangeItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"账户变动" actionHandleBlock:^{
        TCUserChangeViewController *cvc = [[TCUserChangeViewController alloc] init];
        [self.navigationController pushViewController:cvc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *collectServiceItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"联系客服" actionHandleBlock:^{
        TCConnetServiceViewController *cvc  = [[TCConnetServiceViewController alloc] init];
        [self.navigationController pushViewController:cvc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *userInfoItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"个人资料" actionHandleBlock:^{
        TCUserInfoViewController *uvc = [[TCUserInfoViewController alloc] init];
        [self.navigationController pushViewController:uvc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *changeAvoidItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"修改解禁" actionHandleBlock:^{
        TCChangeAvoidViewController *avc = [[TCChangeAvoidViewController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *changePwdItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"修改密码" actionHandleBlock:^{
        TCChangePwdViewController *cvc = [[TCChangePwdViewController alloc] init];
        [self.navigationController pushViewController:cvc animated:YES];
    }];
    
    TCMHSwitchCellConfigModel *voiceSwitchItem = [[TCMHSwitchCellConfigModel alloc] initWithHeadImaName:@"" title:@"语音提醒" actionHandleBlock:^{
        
    }];
    
    TCMHBasicCellConfigModel *downloadAppItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"" title:@"APP下载" actionHandleBlock:^{
        TCAppDownloadViewController *avc = [[TCAppDownloadViewController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }];
    
    return @[accountChangeItem,collectServiceItem,userInfoItem,changeAvoidItem,changePwdItem,voiceSwitchItem,downloadAppItem];
    
}




#pragma mark - getterFunc

- (TNUHeadBgView *)headBgView {
    
    if (!_headBgView) {
        _headBgView = [[TNUHeadBgView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, TMCHHeadViewHeight)];
        _headBgView.imgView.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#e13b29"]];
    }
    return _headBgView;
}

- (TOTableViewTool *)tableViewTool {
    
    if (_tableViewTool == nil) {
        _tableViewTool = [[TOTableViewTool alloc] init];
        _tableViewTool.delegate = self;
    }
    return _tableViewTool;
}

#pragma mark - scollviewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = -scrollView.contentOffset.y;
    if (scrollView.contentOffset.y < 0) {
        self.headBgView.frame = CGRectMake(-offset, -offset, self.view.width + offset * 2, TMCHHeadViewHeight + offset * 2);
        //        self.topBar.bgImav.alpha = 0;
    }
    else if (0 <= scrollView.contentOffset.y && scrollView.contentOffset.y <= TMCHHeadViewHeight) {
        self.headBgView.frame = CGRectMake(0, offset, self.view.width, TMCHHeadViewHeight);
        //        self.topBar.bgImav.alpha = scrollView.contentOffset.y/TMEMRankingHeaderBgImavHeight;
    }
    else {
        self.headBgView.frame = CGRectMake(0, -TMCHHeadViewHeight, self.view.width, TMCHHeadViewHeight);
        //        self.topBar.bgImav.alpha = 1;
    }
    
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
