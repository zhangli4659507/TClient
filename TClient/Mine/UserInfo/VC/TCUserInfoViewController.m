//
//  TCUserInfoViewController.m
//  TClient
//
//  Created by Mark on 2018/9/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCUserInfoViewController.h"

@interface TCUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *QQTxt;
@property (weak, nonatomic) IBOutlet UITextField *weChatTxt;
@property (weak, nonatomic) IBOutlet UITextField *realNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *aliPayTxt;
@property (weak, nonatomic) IBOutlet UITextField *localAreaTxt;

@end

@implementation TCUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)actionSelectArea:(id)sender {
    
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
