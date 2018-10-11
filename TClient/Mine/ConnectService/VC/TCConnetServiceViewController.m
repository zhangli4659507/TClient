//
//  TCConnetServiceViewController.m
//  TClient
//
//  Created by Mark on 2018/10/11.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCConnetServiceViewController.h"
#import "TCServiceInfoModel.h"
@interface TCConnetServiceViewController ()
@property (weak, nonatomic) IBOutlet UIButton *QQBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIImageView *QRImav;
@property (nonatomic, strong) TCServiceInfoModel *configModel;

@end

@implementation TCConnetServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}


- (void)configUIWithModel:(TCServiceInfoModel *)model {
    
    [self.QRImav sd_setImageWithURL:[NSURL URLWithString:kUnNilStr(model.path)] placeholderImage:nil];
    [self.QQBtn setTitle:kUnNilStr(model.qq) forState:UIControlStateNormal];
    [self.wxBtn setTitle:kUnNilStr(model.wechat) forState:UIControlStateNormal];
}

#pragma mark - requestData

- (void)requestData {
    
    [TLodingHub setGifOnView:self.view withTitle:@"正在加载..."];
    [TFailhub hidenALLFailhubWithSuperView:self.view];
    [THTTPRequestTool getRequestDataWithUrl:@"api/xiadan/customer_service" par:nil finishBlock:^(TResponse *response) {
        [TLodingHub hideAllHUDsForView:self.view];
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            TCServiceInfoModel *model = [TCServiceInfoModel mj_objectWithKeyValues:response.data];
            [self configUIWithModel:model];
            self.configModel = model;
        } else {
            WEAK_REF(self);
            [TFailhub showFailHubWithSuperView:self.view reloadBlock:^{
                [weak_self requestData];
            }];
        }
    }];
}



#pragma mark - actionFunc

- (IBAction)actionQQBtn:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = kUnNilStr(self.configModel.qq);
    [MBProgressHUD showSuccess:@"复制成功"];
    
}


- (IBAction)actionWxBtn:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = kUnNilStr(self.configModel.wechat);
    [MBProgressHUD showSuccess:@"复制成功"];
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
