//
//  NSString+AES128.h
//  ceshi
//
//  Created by hushuangfei on 16/7/23.
//  Copyright © 2016年 胡双飞. All rights reserved.
//  AES/CBC/PKCS5Padding 

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
@interface NSString (AES128)

+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
@end
