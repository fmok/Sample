//
//  AESControl.h
//  Sample
//
//  Created by wjy on 2018/8/16.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESViewController.h"

@interface AESControl : NSObject

@property (nonatomic, weak) AESViewController *vc;

/**
 生成AES加密文件
 */
- (void)AESDeal;
/**
 AESDecrypt
 */
- (id)getTarotFormattedDataSourceWithFileName:(NSString *)name;


@end
