//
//  TScanController.m
//  Examda
//
//  Created by liqi on 2018/1/5.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TScanController.h"
#import <AVFoundation/AVFoundation.h>
// tool
#import "TSAudio.h"
#import "TSPhotoPicker.h"
#import "TCaptureSession.h"
// view
#import "TScanView.h"
#import "TSTopView.h"

static NSString * const ALERT_CHECK_AUTH = @"设备未授权使用摄像头，请在设置->隐私中进行设置！";
static CGSize TRANSPARENT_AREA;

@interface TScanController ()

@property (nonatomic, strong) TScanView *scanningView;
@property (nonatomic, strong) TSPhotoPicker *photoPicker;
@property (nonatomic, strong) TCaptureSession *captureSession;
//@property (nonatomic, strong) TSResult *resulter;

@end

@implementation TScanController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    TRANSPARENT_AREA = CGSizeMake(205, 205);
    [self checkAuth];
    [self setupScanningView];
    [self setupTopView];
    [self setupCaptureSession];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.captureSession startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.captureSession stopRunning];
}

#pragma mark - Check Auth

- (void)checkAuth
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        //无权限
        MMAlertView *alertView = [[MMAlertView alloc] initWithConfirmTitle:@"提示" detail:ALERT_CHECK_AUTH];
        [alertView show];
    }
}

#pragma mark - Scanning View

- (void)setupScanningView
{
    self.scanningView = [[TScanView alloc] initWithFrame:self.view.bounds transparentArea:TRANSPARENT_AREA];
    self.scanningView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scanningView];
    [self.scanningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Top View

- (void)setupTopView
{
    CGFloat height = 100;
    CGFloat width = self.view.bounds.size.width;
    CGFloat x = 0;
    CGFloat y = kMaxHeightForStatus - 20;
    TSTopView *topView = [TSTopView loadInstanceFromNib];
    topView.frame = CGRectMake(x, y, width, height);
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    
    __weak typeof(self) weakSelf = self;
    topView.openPhotoLibrary = ^{
        if (!weakSelf) return ;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf openPhotoPicker];
    };
    topView.closeScanning = ^{
        if (!weakSelf) return ;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf navBackAction:nil];
        
    };
}

- (void)navBackAction:(void (^)())completion{
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        !completion?:completion();
    } else if(self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:completion];
    } else {
        [self dismissViewControllerAnimated:YES completion:completion];
    }
}

#pragma mark - PhotoPicker

- (TSPhotoPicker *)photoPicker
{
    if (!_photoPicker) {
        __weak typeof(self) weakSelf = self;
        _photoPicker = [[TSPhotoPicker alloc] initWithParentController:self];
        _photoPicker.getInfoFromImage = ^(NSString * _Nonnull content, BOOL success) {
            if (!weakSelf) return ;
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (success) {
                [strongSelf navBackAction:^{
                 !strongSelf.scanSuccessBlock?:strongSelf.scanSuccessBlock(content);
                }];
               
            }
            else {
                [strongSelf navBackAction:nil];
                [MBProgressHUD showError:@"扫描失败"];
            }
        };
    }
    return _photoPicker;
}

- (void)openPhotoPicker
{
    BOOL isCanOpenPhotoPicker = [self.photoPicker check];
    if (!isCanOpenPhotoPicker) return;
    [self.photoPicker open];
}

#pragma mark - CaptureSession

- (void)setupCaptureSession
{
    __weak typeof(self) weakSelf = self;
    self.captureSession = [[TCaptureSession alloc] initWithParentView:self.view scanningRect:TRANSPARENT_AREA];
    self.captureSession.getInfoFromScanning = ^(NSString * _Nonnull content, BOOL success) {
        if (!weakSelf) return ;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (success) {
            [strongSelf navBackAction:^{
             !strongSelf.scanSuccessBlock?:strongSelf.scanSuccessBlock(content);
            }];
            
        }
        else {
            [strongSelf navBackAction:nil];
            [MBProgressHUD showError:@"扫描失败"];
        }
    };
}

#pragma mark - Result



#pragma mark - 禁止旋转

-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
