//
//  TCSelectAreaView.m
//  TClient
//
//  Created by Mark on 2018/9/6.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCSelectAreaView.h"
#import "T2TView.h"
#import "TAreaTool.h"
static NSNotificationName const TCAreaViewHideNoti = @"TCAreaViewHideNoti";
static CGFloat const TAreaViewHeight = 200.f;
@interface TAreaBgView:UIView
@end
@interface TCSelectAreaView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, copy) NSArray<TAreaModel *> *areaModelsArray;
@property (nonatomic, copy) void (^finshSelectedBlock)(TAreaModel *areaModel);
@property (nonatomic, strong) TAreaModel *selectedAreaModel;
//@property (nonatomic, )
@end



@implementation TAreaBgView
@end

@implementation TCSelectAreaView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [T2TView setRoundCornerFor:self.okBtn radiu:12.5f];
     [T2TView setRoundCornerFor:self.cancelBtn radiu:12.5f];
    self.areaPickView.delegate = self;
    self.areaPickView.dataSource = self;
    [self setup];
}

- (void)setup {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiden) name:TCAreaViewHideNoti object:nil];
    [TAreaTool areaModelListWithFinishBlock:^(NSArray<TAreaModel *> *areaModelList) {
        self.areaModelsArray = areaModelList;
        [self.areaPickView reloadAllComponents];
    }];
}

+ (void)showAreaSlectedViewWithFinshSelectedBlock:(void (^)(TAreaModel *areaModel))finshSelectedBlock {
   
    TAreaBgView *bgView = [[TAreaBgView alloc] initWithFrame:kCurrentWindow.bounds];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#000" alpha:0.3];
    [kCurrentWindow addSubview:bgView];
    
    TCSelectAreaView *areaView = [TCSelectAreaView loadInstanceFromNib];
    areaView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, TAreaViewHeight);
    areaView.finshSelectedBlock = finshSelectedBlock;
    [bgView addSubview:areaView];

    
    [UIView animateWithDuration:0.35
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         areaView.top = kScreenHeight - TAreaViewHeight;
                     }
                     completion:^(BOOL finished) {
    }];

}

- (void)hiden {
    
    if (!self || !self.superview) {
        return;
    }
 
    [UIView animateWithDuration:0.35
                              delay:0
                            options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             self.top = kScreenHeight;
                             
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [self.superview performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
                             }
        }];
}

+ (void)hiden {
    [[NSNotificationCenter defaultCenter] postNotificationName:TCAreaViewHideNoti object:nil];
}

- (IBAction)actionSureBtn:(id)sender {
    [self hiden];
    !self.finshSelectedBlock?:self.finshSelectedBlock(self.selectedAreaModel);
}
- (IBAction)actionCancelBtn:(id)sender {
  [self hiden];
}

#pragma mark - UIPickerViewDelegateAndDatasource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.areaModelsArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.areaModelsArray.count > row) {
        TAreaModel *areaModel = self.areaModelsArray[row];
        return kUnNilStr(areaModel.name);
    }
    return @"北京市";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.areaModelsArray.count > row) {
        TAreaModel *areaModel = self.areaModelsArray[row];
        self.selectedAreaModel = areaModel;
    }
}

- (void)dealloc {
 
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
