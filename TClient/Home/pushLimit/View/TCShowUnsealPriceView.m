//
//  TCShowUnsealPriceView.m
//  TClient
//
//  Created by mark_zhang on 2018/10/30.
//  Copyright © 2018年 Mark. All rights reserved.
//

#import "TCShowUnsealPriceView.h"
#import "TCUnsealPriceTableViewCell.h"
@interface TCShowUnsealPriceView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) void(^selectBlock)(CGFloat unsealPrice);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSNumber *> *unselPriceArray;

@end
@implementation TCShowUnsealPriceView
+ (void)showUnsealPriceViewWithUnsealPriceArr:(NSArray<NSNumber *> *)unsealPriceArray selectBlock:(void(^)(CGFloat unsealPrice))selectBlock {
    TCShowUnsealPriceView *priceView = [[TCShowUnsealPriceView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kSafeBottomLayGuideHeight, kScreenWidth, unsealPriceArray.count * 40.f + 35.f)];
    priceView.selectBlock = selectBlock;
    priceView.unselPriceArray = unsealPriceArray;
    [priceView show];
    
}


- (void)show {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#000" alpha:0.3f];
    [kCurrentWindow addSubview:bgView];
    
    UIControl *control = [[UIControl alloc] initWithFrame:bgView.bounds];
    [control addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:control];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
//    [bgView addGestureRecognizer:tap];
    
    
    [bgView addSubview:self];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.top = kScreenHeight -  self.height - kSafeBottomLayGuideHeight;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)close {
    
    [UIView animateWithDuration:0.35 animations:^{
        self.top = kScreenHeight - kSafeBottomLayGuideHeight;
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
        [self removeFromSuperview];
    }];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupSubview];
    }
    return self;
    
}


- (void)setupSubview {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, CGFLOAT_MIN)];
    [self.tableView registerNibName:TCUnsealPriceTableViewCellClassName forCellReuseIdentifier:TCUnsealPriceTableViewCellClassName];
    [self addSubview:self.tableView];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 35.f)];
    lbl.text = @"请选择解封佣金";
    lbl.textColor = [UIColor colorWithHexString:@"#e13b29"];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont boldSystemFontOfSize:14.f];
    lbl.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = lbl;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.unselPriceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TCUnsealPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TCUnsealPriceTableViewCellClassName];
    if (self.unselPriceArray.count > indexPath.row) {
        cell.priceLbl.text = [NSString stringWithFormat:@"%@元",self.unselPriceArray[indexPath.row]];
    }
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (self.unselPriceArray.count > indexPath.row && self.selectBlock) {
         self.selectBlock([self.unselPriceArray[indexPath.row] floatValue]);
    }
    [self close];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
