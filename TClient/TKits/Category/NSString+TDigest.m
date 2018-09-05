//
//  NSString+TDigest.m
//  HouseKeeper
//
//  Created by mark to on 12-12-12.
//  Copyright (c) 2014年 233. All rights reserved.
//

#import "NSString+TDigest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TDigest)
- (NSString *)md5Digest
{
    const char* cstr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, strlen(cstr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}


- (NSString *)getMd5_16Bit
{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

- (NSString *)getMd5_32Bit
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

-(NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)rangeFont  rangeColor:(UIColor*)rangeColor otherStrFont:(UIFont *)font clolor:(UIColor *)color{
 
   
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *att  = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributeWithRangeOfString:aString Font:rangeFont color:rangeColor]];
    if (range.location != 0 && range.length > 0) {
       NSRange rangePre = NSMakeRange(0, range.location);
        [att addAttribute:NSForegroundColorAttributeName value:color range:rangePre];
        [att addAttribute:NSFontAttributeName value:font range:rangePre];
      
    }
    if (range.location+range.length<self.length) {
        NSUInteger len = self.length-range.location-range.length;
        NSRange endRange = NSMakeRange(range.location+range.length,len);
        [att addAttribute:NSForegroundColorAttributeName value:color range:endRange];
        [att addAttribute:NSFontAttributeName value:font range:endRange];
    }
    return att;
}

- (NSAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)rangeFont  rangeColor:(UIColor*)rangeColor otherStrFont:(UIFont *)font clolor:(UIColor *)color onlyOnce:(BOOL)once {
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
    NSMutableArray *rangsList = [NSMutableArray array];
    [self searchRange:self keyWord:aString withStoreArray:rangsList andStartIndex:0];
    for (NSValue *value in rangsList) {
        NSRange range = [value rangeValue];
        [att addAttributes:@{NSForegroundColorAttributeName:rangeColor,NSFontAttributeName:rangeFont} range:range];
        if (once) {
            break;
        }
    }
    return att;
}

-(void)searchRange:(NSString *)sourceString keyWord:(NSString *)keyword withStoreArray:(NSMutableArray *)storeArray andStartIndex:(NSInteger)startIndex {
    NSRange tmpRange=[sourceString rangeOfString:keyword];
    if(tmpRange.location!=NSNotFound)
    {
        NSValue *value = [NSValue valueWithRange:NSMakeRange(tmpRange.location+startIndex, tmpRange.length)];
        [storeArray addObject:value];
        sourceString=[sourceString substringFromIndex:tmpRange.location+tmpRange.length];
        startIndex=tmpRange.location+tmpRange.length+startIndex;
        [self searchRange:sourceString keyWord:keyword withStoreArray:storeArray andStartIndex:startIndex];
    }
}



- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString color:(UIColor *)color
{
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attribute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:range];
    return attribute;
}

- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)font{
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
    [attribute addAttribute:NSFontAttributeName value:font range:range];
    return attribute;
}

- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)font color:(UIColor *)color{
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attribute addAttribute:NSFontAttributeName value:font range:range];
    return attribute;

}

- (NSString *)trimSpace
{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimAllSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSUInteger)t_lenght{
    
    NSUInteger len = 0;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    len = [self lengthOfBytesUsingEncoding:enc];
    return len;
   
}

-(BOOL)isAllNum{
    unichar c;
    for (int i=0; i<self.length; i++) {
        c=[self characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}


-(NSString *)filterHTML:(NSString *)html
{
//    NSScanner * scanner = [NSScanner scannerWithString:html];
//    NSString * text = nil;
//    while([scanner isAtEnd]==NO)
//    {
//        //找到标签的起始位置
//        [scanner scanUpToString:@"<" intoString:nil];
//        //找到标签的结束位置
//        [scanner scanUpToString:@">" intoString:&text];
//        //替换字符
//        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
//    }
    NSString * regEx = @"<([^>]*)>";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

- (BOOL)isBlankString {
    
    if (self == nil || self == NULL) {
        
        return YES;
        
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

@end
