//
//  TAlertController.m
//  Examda
//
//  Created by Kane.Zhu on 2017/8/15.
//  Copyright © 2017年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TAlertController.h"

@implementation TAlertController

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation==UIInterfaceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate {
    
    return NO;
}
@end
