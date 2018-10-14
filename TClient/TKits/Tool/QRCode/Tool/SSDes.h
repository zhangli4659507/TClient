//
//  SSDes.h
//  AA3DESDemo
//
//  Created by luoluo on 15/8/13.
//  Copyright © 2015年 Arlexovincy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSDes : NSObject

/**
 *  des加密
 *
 *  @param encryptString 待加密的string
 *  @param keyString     约定的密钥
 *  @param ivString      约定的密钥
 *
 *  @return des加密后的string
 */
+ (NSString*)getEncryptWithString:(NSString*)encryptString keyString:(NSString*)keyString ivString:(NSString*)ivString;

/**
 *  des解密
 *
 *  @param decryptString 待解密的string
 *  @param keyString     约定的密钥
 *  @param ivString      约定的密钥
 *
 *  @return des解密后的string
 */
+ (NSString*)getDecryptWithString:(NSString*)decryptString keyString:(NSString*)keyString ivString:(NSString*)ivString;

@end
