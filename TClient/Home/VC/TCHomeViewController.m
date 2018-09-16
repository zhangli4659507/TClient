//
//  TCHomeViewController.m
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCHomeViewController.h"
#import "TCHomeModel.h"
#import "TCHomeCommissionTypeView.h"
@interface TCHomeViewController ()
@property (nonatomic, strong) TCHomeModel *homeModel;
@property (weak, nonatomic) IBOutlet UIView *moneyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyHight;
@property (nonatomic, strong) TCHomeCommissionTypeView *moneyTypeView;
@property (nonatomic, weak) TCHomeMoneyTypeModel *selectMoneyModel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UIButton *addMonryButton;
@end

@implementation TCHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubview];
    [self layOutSubview];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - setupSubview

- (void)setupSubview {

    self.moneyTypeView = [[TCHomeCommissionTypeView alloc] init];
    [self.moneyView addSubview:self.moneyTypeView];
    
    [T2TView setRoundCornerFor:self.addMonryButton radiu:4.f];
    
}

- (void)layOutSubview {
    
    [self.moneyTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyView).offset(72.f);
        make.top.right.bottom.equalTo(self.moneyView);
    }];
}


#pragma mark - requestData

- (void)requestData {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [parInfoDic setObject:@{} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [TLodingHub setGifOnView:self.view withTitle:nil];
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    [THTTPRequestTool getSignRequestDataWithUrl:@"api/xiadan/index/index" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        [TLodingHub hideAllHUDsForView:self.view];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            self.homeModel = [TCHomeModel mj_objectWithKeyValues:response.data];
            [self setupData];
        } else {
            WEAK_REF(self);
            [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
                [weak_self requestData];
            }];
        };
    }];
}

- (void)setupData {
    self.moneyLbl.text = [NSString stringWithFormat:@"%.1lf元",self.homeModel.money];
    WEAK_REF(self);
    CGFloat height = [self.moneyTypeView reloadWithConfigMoneyArr:self.homeModel.configArr selectModelBlock:^(TCHomeMoneyTypeModel *typeModel) {
        weak_self.selectMoneyModel = typeModel;
    } width:kScreenWidth - 72.f];
    self.moneyHight.constant = MAX(50.f, height);
}


#pragma mark - actionFunc

- (IBAction)actionPicUp:(id)sender {
    
}

- (IBAction)actionQRUp:(id)sender {
    
}
- (IBAction)actionAddMoney:(id)sender {
}


- (IBAction)actionReleaseLimit:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
