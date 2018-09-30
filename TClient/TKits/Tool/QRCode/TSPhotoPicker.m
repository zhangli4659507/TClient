//
//  TSPhotoPicker.m
//  Examda
//
//  Created by liqi on 2018/1/8.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TSPhotoPicker.h"
// tool
#import "TSAudio.h"
#import "ZXingObjC.h"

@interface TSPhotoPicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIViewController *parentController;

@end

@implementation TSPhotoPicker

- (instancetype)initWithParentController:(UIViewController *)parentController
{
    self = [super init];
    if (self) {
        _parentController = parentController;
        [self setupImagePickerController];
    }
    return self;
}

- (void)setupImagePickerController
{
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = NO;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerController.navigationBar.translucent = NO;
    self.imagePickerController.mediaTypes = [UIImagePickerController         availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

- (BOOL)check
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //判断设备是否支持相册
        if (IOS8) {
            MMAlertView *alertView = [[MMAlertView alloc] initWithConfirmTitle:@"提示" detail:@"未开启访问相册权限，现在去开启！"];
            [alertView show];
        }
        else {
            MMAlertView *alertView = [[MMAlertView alloc] initWithConfirmTitle:@"提示" detail:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！"];
            [alertView show];
        }
        return NO;
    }
    return YES;
}

- (void)open
{
    [self.parentController presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerViewControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (!weakSelf) return ;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [TSAudio playAudioWhenScanning];
        [strongSelf dealWithImage:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Dealwith Image

- (void)dealWithImage:(UIImage *)image
{
    UIImage *loadImage = image;
    CGImageRef imageToDecode = loadImage.CGImage;
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    NSError *error = nil;
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap hints:hints error:&error];
    
    if (result) {
        NSString *content = result.text;
        !self.getInfoFromImage?:self.getInfoFromImage(content, YES);
        NSLog(@"相册图片contents == %@",content);
    }
    else {
        !self.getInfoFromImage?:self.getInfoFromImage(@"抱歉！信息解析失败", NO);
    }
        
}

@end
