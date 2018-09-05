//
//  TCMHHeaderCell.m
//  Examda
//
//  Created by Mark on 2018/8/20.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TCMHHeaderCell.h"
#import "T2TView.h"
NSString *const TCMHHeaderCellClassName = @"TCMHHeaderCell";
@implementation TCMHHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [T2TView setRoundCornerFor:self.headerImav radiu:21.5f];
    [T2TView setRoundCornerFor:self.delegateBtn radiu:8.0f];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"星期四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    NSString *dateStr = [NSString stringWithFormat:@"%ld月%ld日 %@",theComponents.month,theComponents.day,[weekdays objectAtIndex:theComponents.weekday]];
    
    return dateStr;
}

- (void)reloadUi {
    
    
    TCUserManger *manger = [TCUserManger shareUserManger];
    if (manger.userModel == nil) {
        return;
    }
    self.dateInfoLbl.text = [self weekdayStringFromDate:[NSDate date]];
    [self.headerImav sd_setImageWithURL:[NSURL URLWithString:kUnNilStr(manger.userModel.avatar)] placeholderImage:kDefaultHeadImg];
    self.nickNameLbl.text = kUnNilStr(manger.userModel.nickname);
    [self.delegateBtn setTitle:kUnNilStr(manger.userModel.type_name) forState:UIControlStateNormal];
    self.orderNumLbl.text = kUnNilStr(manger.userModel.money);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
