//
//  FMRuntimeEngine.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface FMRuntimeEngine : NSObject

/**
 方法交换
 */
+ (void)swizzleMethod:(Class)cls originalSEL:(SEL)originalSelector swizzledSEL:(SEL)swizzledSelector;

/**
 获取类的属性列表 (私有、公有属性，以及拓展中的属性)
 */
+ (NSArray *)fetchPropertyList:(Class)cls;

/**
 获取成员变量
 */
+ (NSArray *)fetchIvarList:(Class)cls;

/**
 获取类名
 */
+ (NSString *)fetchClassName:(Class)cls;

@end
