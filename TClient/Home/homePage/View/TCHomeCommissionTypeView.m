//
//  TCHomeCommissionTypeView.m
//  TClient
//
//  Created by mark_zhang on 2018/9/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCHomeCommissionTypeView.h"
#import "TComputerTextHeightTool.h"
@implementation TCHomeCommissionTypeView

{
    void (^_selectBlock) (TCHomeMoneyTypeModel *typeModel);
    NSArray<TCHomeMoneyTypeModel *> *_configArr;
    NSMutableArray<UIButton *> *_allButton;
    CGFloat _itemWidth;
    CGFloat _itemHeight;
    
}

- (CGFloat)reloadWithConfigMoneyArr:(NSArray<TCHomeMoneyTypeModel *> *)configMoney selectModelBlock:(void(^)(TCHomeMoneyTypeModel *typeModel))selectModelBlock width:(CGFloat)width {
    
    [self removeAllSubviews];
    [_allButton removeAllObjects];
    _allButton = [NSMutableArray arrayWithCapacity:configMoney.count];
    _itemWidth = width/3.f;
    _itemHeight = 35.f;
    _configArr = configMoney;
    _selectBlock = selectModelBlock;
    [self setupSubviews];
    return ceilf(configMoney.count/3.0)* _itemHeight;
}

- (void)setupSubviews {
   
    for (NSInteger index = 0; index < _configArr.count; index ++) {
        TCHomeMoneyTypeModel *configModel = _configArr[index];
        CGFloat firstNum = index/3;
        CGFloat secondNum = index % 3;
        CGFloat origh_y = firstNum * _itemHeight;
        CGFloat origh_x = secondNum * _itemWidth;
        UIButton *button = [self selectButtonWithConfigMoneyModel:configModel];
        button.frame = CGRectMake(origh_x, origh_y, _itemWidth, _itemHeight);
        button.tag = index;
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_allButton addObject:button];
    }
}

- (UIButton *)selectButtonWithConfigMoneyModel:(TCHomeMoneyTypeModel *)moneyModel {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [button setImage:kImaWithImaName(@"icon_home_noSlected") forState:UIControlStateNormal];
    [button setImage:kImaWithImaName(@"icon_home_Slected") forState:UIControlStateSelected];
    button.selected = moneyModel.isFirstSelected;
    [button setTitle:moneyModel.showTitle forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12.f];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    return button;
    
}

- (void)actionButton:(UIButton *)button {
    
    for (UIButton *btn in _allButton) {
        btn.selected = NO;
    }
    button.selected = YES;
    !_selectBlock?:_selectBlock(_configArr[button.tag]);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
