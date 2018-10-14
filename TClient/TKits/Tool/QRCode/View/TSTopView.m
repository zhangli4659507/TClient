//
//  TSTopView.m
//  Examda
//
//  Created by liqi on 2018/1/5.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TSTopView.h"
// tool
#import "TSPhotoFlash.h"

@implementation TSTopView

#pragma mark - Event Methods

- (IBAction)openPhoto:(UIButton *)sender
{
    !self.openPhotoLibrary?:self.openPhotoLibrary();
}

- (IBAction)openAndClosePhotoFlash:(UIButton *)sender
{
    if (sender.isSelected) {
        [TSPhotoFlash close];
    }
    else {
        [TSPhotoFlash open];
    }
    sender.selected = !sender.isSelected;
}

- (IBAction)closeScanning:(UIButton *)sender
{
    !self.closeScanning?:self.closeScanning();
}

@end
