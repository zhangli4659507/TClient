//
//  TCaptureSession.m
//  Examda
//
//  Created by liqi on 2018/1/8.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TCaptureSession.h"
// tool
#import <UIKit/UIKit.h>
#import "TSAudio.h"
// catogery
#import "AVCaptureSession+TDeviceOrientation.h"

@interface TCaptureSession () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation TCaptureSession

- (instancetype)initWithParentView:(UIView *)parentView scanningRect:(CGSize)scanningRect
{
    self = [super init];
    if (self) {
        //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //2.用captureDevice创建输入流
        NSError *error;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        if (!input) {
            NSLog(@"%@", [error localizedDescription]);
            return nil;
        }
        //3.创建媒体数据输出流
        AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
        
        //4.实例化捕捉会话
        _captureSession = [[AVCaptureSession alloc] init];
        [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_captureSession canAddInput:input]) {
            [_captureSession addInput:input];
            
        }
        if ([_captureSession canAddOutput:captureMetadataOutput]) {
            [_captureSession addOutput:captureMetadataOutput];
        }
        
        //创建串行队列，并加媒体输出流添加到队列当中
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create("233_captureMetadataOutput_queue", NULL);
        [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
        
        AVCaptureConnection *outputConnection = [captureMetadataOutput connectionWithMediaType:AVMediaTypeVideo];
        outputConnection.videoOrientation = [AVCaptureSession videoOrientationFromCurrentDeviceOrientation];
        CGFloat viewHeight = parentView.frame.size.height;
        //设置输出媒体数据类型为QRCode
        [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,      //二维码
                                                        AVMetadataObjectTypeCode39Code,  //条形码   韵达和申通
                                                        AVMetadataObjectTypeCode128Code, //CODE128条码  顺丰用的
                                                        AVMetadataObjectTypeCode39Mod43Code,
                                                        AVMetadataObjectTypeEAN13Code,
                                                        AVMetadataObjectTypeEAN8Code,
                                                        AVMetadataObjectTypeCode93Code,//条形码,星号来表示起始符及终止符,如邮政EMS单上的条码
                                                        AVMetadataObjectTypeUPCECode]];
        
        CGFloat viewWidth = parentView.frame.size.width;
        CGRect cropRect = CGRectMake((viewWidth - scanningRect.width) / 2,
                                     (viewHeight - scanningRect.height) / 2,
                                     scanningRect.width,
                                     scanningRect.height);
        CGRect interestRect = CGRectMake(cropRect.origin.y / viewHeight,
                                         cropRect.origin.x / viewWidth,
                                         cropRect.size.height / viewHeight,
                                         cropRect.size.width / viewWidth);
        [captureMetadataOutput setRectOfInterest:interestRect];
        
        //5.实例化预览图层
        _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResize];
        [_videoPreviewLayer setFrame:parentView.bounds];
        //将图层添加到预览view的图层上
        [parentView.layer insertSublayer:_videoPreviewLayer atIndex:0];
        _videoPreviewLayer.connection.videoOrientation = [AVCaptureSession videoOrientationFromCurrentDeviceOrientation];
    }
    return self;
}

- (void)startRunning
{
    if (![self.captureSession isRunning]) {
        [self.captureSession startRunning];
    }
}

- (void)stopRunning
{
    if ([self.captureSession isRunning]) {
        [self.captureSession stopRunning];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
   
    if ([metadataObjects count] >0) {
        //停止扫描
        [_captureSession stopRunning];
        [TSAudio playAudioWhenScanning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *stringValue = metadataObject.stringValue;
        //判断回传的数据类型
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[metadataObject type] isEqualToString:AVMetadataObjectTypeQRCode]) {
                //二维码
                !self.getInfoFromScanning?:self.getInfoFromScanning(stringValue, YES);
                NSLog(@"二维码：%@",stringValue);
            }
            else {
                //条形码
                NSString *msg = [NSString stringWithFormat:@"条形码：%@",stringValue];
                !self.getInfoFromScanning?:self.getInfoFromScanning(msg, NO);
                NSLog(@"条形码：%@",stringValue);
            }
        });
    }
}

@end
