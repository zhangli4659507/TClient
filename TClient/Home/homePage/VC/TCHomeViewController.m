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
#import "TUploadTool.h"
#import "TCPushLimitViewController.h"
#import "TCCommonSenseVC.h"
#import "TCRechargeViewController.h"
@interface TCHomeViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) TCHomeModel *homeModel;
@property (weak, nonatomic) IBOutlet UIView *moneyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyHight;
@property (nonatomic, strong) TCHomeCommissionTypeView *moneyTypeView;
@property (nonatomic, weak) TCHomeMoneyTypeModel *selectMoneyModel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UIButton *addMonryButton;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@end

@implementation TCHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"首页";
    [self setupSubview];
    [self layOutSubview];
    [self requestData];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"公告" titleColor:[UIColor whiteColor] target:self action:@selector(actionCommonInfo)];
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
    self.selectMoneyModel = [self.homeModel.configArr firstObject];
    WEAK_REF(self);
    CGFloat height = [self.moneyTypeView reloadWithConfigMoneyArr:self.homeModel.configArr selectModelBlock:^(TCHomeMoneyTypeModel *typeModel) {
        weak_self.selectMoneyModel = typeModel;
    } width:kScreenWidth - 72.f];
    self.moneyHight.constant = MAX(50.f, height);
}

- (void)uploadImageWithIma:(UIImage *)image {
    
    
    [MBProgressHUD showMessage:@"正在上传...." toView:self.view];
    
    [TUploadTool uploadImge:image finishBlock:^(NSString *imageUrlString) {
        [MBProgressHUD hideHUDForView:self.view];
        [self requestPicUpWithUrl:imageUrlString];
    }];
    
}
- (void)requestPicUpWithUrl:(NSString *)imaPath {
    
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    [parInfoDic setObject:@{@"order_price":@(self.selectMoneyModel.money),@"photo_url":kUnNilStr(imaPath)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"order_price":@(self.selectMoneyModel.money),@"photo_url":kUnNilStr(imaPath)}];
    [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/create_order_photo" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
        } else {
            [MBProgressHUD showError:response.msg toView:self.view];
        }
    }];
}


#pragma mark - privateFunc

- (void)callActionSheetFunc {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

#pragma mark - actionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self uploadImageWithIma:image];
//    self.headImage.image = image;
}

#pragma mark - actionFunc

- (void)actionCommonInfo {
    TCCommonSenseVC *cvc = [[TCCommonSenseVC alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
    
}

- (IBAction)actionPicUp:(id)sender {
    [self callActionSheetFunc];
}

- (IBAction)actionQRUp:(id)sender {
    
}
- (IBAction)actionAddMoney:(id)sender {
    
    TCRechargeViewController *rvc = [[TCRechargeViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
    
}


- (IBAction)actionReleaseLimit:(id)sender {
    
    TCPushLimitViewController *lvc = [[TCPushLimitViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
