//
//  NSDate+AES.h
//  Tarot
//
//  Created by wjy on 2018/8/16.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

//加密
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

//解密
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;


@end
