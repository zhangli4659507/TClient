//
//  TCOrderComplaintVC.m
//  TClient
//
//  Created by mark_zhang on 2018/11/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCOrderComplaintVC.h"
#import "TUploadTool.h"
@interface TCOrderComplaintVC ()<UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UIImageView *uploadImav;
@property (nonatomic, copy) NSString *imagePath;
@end

@implementation TCOrderComplaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉";
    [T2TView setRoundCornerFor:self.button radiu:20.f];
    [self.button addTarget:self action:@selector(actionUploadImage) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)actionUploadImage:(id)sender {
    UIActionSheet* actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    actionSheet.tag = 1000;
    [actionSheet showInView:self.view];
}

- (void)actionUploadImage {
    if (self.imagePath.length == 0) {
        [MBProgressHUD showError:@"请先上传图片"];
        return;
    }
    [self requestComplaintWithImaUrl:self.imagePath];
}

- (void)requestComplaintWithImaUrl:(NSString *)complain_img_url {
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str)}];
    NSString *orderKey = self.complaintType != TCOrderComplaintRegister?@"jiedan_id":@"order_id";
    [parInfoDic setObject:@{orderKey:@(self.order_id),@"complain_img_url":kUnNilStr(complain_img_url)} forKey:@"data"];
    NSMutableDictionary *signDicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),orderKey:@(self.order_id),@"complain_img_url":kUnNilStr(complain_img_url)}];
    [MBProgressHUD showMessage:@"正在提交..."];
    [THTTPRequestTool postSignRequestDataWithUrl:self.complaintType == TCOrderComplaintRegister?@"api/xiadan/complain/register_order_complain":@"api/xiadan/complain/unseal_order_complain" par:parInfoDic signDicInfo:signDicInfo finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode) {
            [MBProgressHUD hideHUD];
            [self navBackAction];
            !self.complaintSuccessBlock?:self.complaintSuccessBlock();
        } else {
            [MBProgressHUD showError:kUnNilStr(response.msg)];
        }
    }];
}

- (void)uploadImageWithIma:(UIImage *)image {
    
    [MBProgressHUD showMessage:@"正在上传...."];
    
    [TUploadTool uploadImge:image finishBlock:^(NSString *imageUrlString) {
        if (imageUrlString.length == 0) {
            [MBProgressHUD showError:@"上传失败"];
        } else {
            
            [MBProgressHUD showSuccess:@"上传成功"];
            self.uploadImav.image = image;
            self.imagePath = imageUrlString;
        }
//        [self requestPicUpWithUrl:imageUrlString];
    }];
    
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

@end
