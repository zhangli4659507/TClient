//
//  TCSelectAreaView.h
//  TClient
//
//  Created by Mark on 2018/9/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAreaModel.h"
@interface TCSelectAreaView : UIView
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *areaPickView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


+ (void)showAreaSlectedViewWithFinshSelectedBlock:(void(^)(TAreaModel *areaModel))finshSelectedBlock;
+ (void)hiden;
@end
