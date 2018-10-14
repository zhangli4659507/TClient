//
//  TSFailureController.m
//  Examda
//
//  Created by liqi on 2018/1/8.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TSFailureController.h"

@interface TSFailureController ()

@property (weak, nonatomic) IBOutlet UILabel *msgLbl;

@end

@implementation TSFailureController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"扫描结果";
    self.msgLbl.text = self.msg;
}


#pragma mark - Setter Methods

- (void)setMsg:(NSString *)msg
{
    _msg = [msg copy];
    self.msgLbl.text = msg;
}



@end
