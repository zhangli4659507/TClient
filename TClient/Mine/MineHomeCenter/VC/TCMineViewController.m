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
#import "TCCommonSenseVC.h"
#import "TCUnderMerchantVC.h"
#import "TCInviteFriendVC.h"
#import "TCAccountChangeVC.h"
#import "TCRechargeRecordVC.h"
#import "TCRegisterQueryVC.h"
#import "TCChangePwdViewController.h"
#import "TCUserInfoViewController.h"
#import "TCConnetServiceViewController.h"
#import "TCUserChangeViewController.h"
#import "TCRegisterViewController.h"
#import "TCMHTableFootView.h"
#import "EGetCacheSize.h"
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupData) name:TLogin_Out_NotiName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupData) name:TLogin_success_notiName object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.tableFooterView.height = 100.f;
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
    
    TCMHTableFootView *footView = [TCMHTableFootView loadInstanceFromNib];
    footView.height = 100.f;
    self.tableView.tableFooterView = footView;
    [footView setActionLoginOut:^{
        [[TCUserManger shareUserManger] loginOut];
    }];
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
    TCUserInfoModel *userModel = [TCUserManger shareUserManger].userModel;
    
    TCMHBasicCellConfigModel *registerQueryItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_search" title:@"注册查询" actionHandleBlock:^{
        TCRegisterQueryVC *ivc = [[TCRegisterQueryVC alloc] init];
        [self.navigationController pushViewController:ivc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *rechargeRecordItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_czjl" title:@"充值记录" actionHandleBlock:^{
        TCRechargeRecordVC *ivc = [[TCRechargeRecordVC alloc] init];
        [self.navigationController pushViewController:ivc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *accountChangeItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_zhbd" title:@"账户变动" actionHandleBlock:^{
        TCAccountChangeVC *ivc = [[TCAccountChangeVC alloc] init];
        [self.navigationController pushViewController:ivc animated:YES];
    }];
    
    TCMHInfoCellConfigModel *myInviteCodeItem = [[TCMHInfoCellConfigModel alloc] initWithHeadImaName:@"icon_mine_wdtjm" title:@"我的推荐码" actionHandleBlock:nil];
    myInviteCodeItem.info = userModel.referral_code;
    
    TCMHBasicCellConfigModel *inviteFriendItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"incon_mine_yqhs" title:@"邀请号商" actionHandleBlock:^{
        TCInviteFriendVC *ivc = [[TCInviteFriendVC alloc] init];
        [self.navigationController pushViewController:ivc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *UnderMerchantItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_xjhs" title:@"下级号商" actionHandleBlock:^{
        TCUnderMerchantVC *ivc = [[TCUnderMerchantVC alloc] init];
        [self.navigationController pushViewController:ivc animated:YES];
    }];
    
    return @[registerQueryItem,rechargeRecordItem,accountChangeItem,myInviteCodeItem,inviteFriendItem,UnderMerchantItem];
}

- (NSArray<TCMHCellConfigModel *> *)thirdSectionItems {
   
    TCMHBasicCellConfigModel *userInfoItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_grzl" title:@"个人资料" actionHandleBlock:^{
        TCUserInfoViewController *uvc = [[TCUserInfoViewController alloc] init];
        [self.navigationController pushViewController:uvc animated:YES];
    }];
    TCMHBasicCellConfigModel *collectServiceItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_lxkf" title:@"联系客服" actionHandleBlock:^{
        TCConnetServiceViewController *cvc  = [[TCConnetServiceViewController alloc] init];
        [self.navigationController pushViewController:cvc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *changePwdItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_xgmm" title:@"修改密码" actionHandleBlock:^{
        TCChangePwdViewController *cvc = [[TCChangePwdViewController alloc] init];
        [self.navigationController pushViewController:cvc animated:YES];
    }];
    
    TCMHBasicCellConfigModel *commonSenseItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_cjwt" title:@"常见问题" actionHandleBlock:^{
        TCCommonSenseVC *avc = [[TCCommonSenseVC alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }];
    TCMHBasicCellConfigModel *cacheItem = [[TCMHBasicCellConfigModel alloc] initWithHeadImaName:@"icon_mine_qchc" title:@"清除缓存" actionHandleBlock:nil];
    WEAK_REF(cacheItem);
    WEAK_REF(self);
    [cacheItem setActionHandleBlock:^{
        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"提示" CancelTitle:@"取消" otherTitle:@"确定" detail:@"是否清空缓存?"];
        [alertView setHandler:^(NSInteger index){
            if (index == 1) {
                MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
                [EGetCacheSize clearCacheWithFinishBlock:^{
                    // 清除图片缓存
                    [hub hide:YES];
                    [MBProgressHUD showSuccess:@"清除完成" toView:weak_self.view];
                    weak_cacheItem.rightInfo = @"0.0M";
                    [weak_self.tableView reloadData];
                }];
            }
        }];
        [alertView show];
    }];
    [EGetCacheSize getCacheSizeWithFinishBlock:^(NSString *size) {
        cacheItem.rightInfo = size;
        [self.tableView reloadData];
    }];
    
    return @[userInfoItem,collectServiceItem,changePwdItem,commonSenseItem,cacheItem];
}

#pragma mark - getterFunc

- (TNUHeadBgView *)headBgView {
    
    if (!_headBgView) {
        _headBgView = [[TNUHeadBgView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, TMCHHeadViewHeight)];
        _headBgView.imgView.image = [UIImage imageWithColor:kThemeColor];
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
