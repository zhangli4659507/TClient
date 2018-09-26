//
//  TCUnlockTaskVC.m
//  TClient
//
//  Created by Mark on 2018/8/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUnlockTaskVC.h"
#import "TCUnlockTaskListModel.h"
@interface TCUnlockTaskVC ()
@property (nonatomic, assign) NSUInteger pgIndex;
@end

@implementation TCUnlockTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.pgIndex = 1;
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)requestData {
    NSDateFormatter *dateFormatter = DateFormatter();
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *parInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"data":@{@"page":@(self.pgIndex)}}];
    NSDictionary *signDic = @{@"timestamp":kUnNilStr(timestamp),@"api_key":kUnNilStr(TApi_key_Str),@"page":@(self.pgIndex)};
    [THTTPRequestTool postSignRequestDataWithUrl:@"api/xiadan/order/get_order_unseal_list" par:parInfoDic signDicInfo:signDic finishBlock:^(TResponse *response) {
        if (response.code == TRequestSuccessCode && [response.data isKindOfClass:[NSDictionary class]]) {
            TCUnlockTaskListModel *listModel = [TCUnlockTaskListModel mj_objectWithKeyValues:response.data];
            NSLog(@"sssss");
        }
    }];
    
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
