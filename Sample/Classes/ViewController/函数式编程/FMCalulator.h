//
//  FMCalulator.h
//  Sample
//
//  Created by wjy on 2019/8/2.
//  Copyright © 2019 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 函数式编程，实现简单计算器
 */

NS_ASSUME_NONNULL_BEGIN

@interface FMCalulator : NSObject

@property (nonatomic, assign) BOOL isEqule;
@property (nonatomic, assign) NSInteger result;

- (FMCalulator *)caculator:(NSInteger (^)(NSInteger result))calulator;

@end

NS_ASSUME_NONNULL_END
