//
//  TComputerTextHeightTool.m
//  Examda
//
//  Created by Mark on 2017/5/4.
//  Copyright © 2017年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TComputerTextHeightTool.h"

@implementation TComputerTextHeightTool
+ (CGFloat)textHeightWithString:(NSString *)string font:(UIFont *)font lineSpace:(CGFloat)lineSpace wid:(CGFloat)wid {
    
    if (!string || string.length == 0 || !font) {
        return 0.f;
    }
    NSAttributedString *att = [self createAttWithFont:font lineSpace:lineSpace string:string];
    static UILabel *stringLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//生成一个同于计算文本高度的label
        stringLabel = [[UILabel alloc] init];
        stringLabel.numberOfLines = 0;
    });
    stringLabel.font = font;
    stringLabel.attributedText = att;
    return [stringLabel sizeThatFits:CGSizeMake(wid, MAXFLOAT)].height ;
}

+ (NSMutableAttributedString *)createAttWithFont:(UIFont *)font lineSpace:(CGFloat)lineSpace string:(NSString *)string {

    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:kUnNilStr(string)];
    [att addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, att.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [att length])];
    
    return att;
}

+ (CGFloat)textWidthWithString:(NSString *)string font:(UIFont *)font {
    
    if (!string || string.length == 0 || !font) {
        return 0.f;
    }
    CGSize size =[string sizeWithAttributes:@{NSFontAttributeName:font}];
    return size.width;
}




@end
