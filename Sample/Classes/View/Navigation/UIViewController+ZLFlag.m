//
//  UIViewController+ZLFlag.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UIViewController+ZLFlag.h"
#import <objc/runtime.h>

@implementation UIViewController (ZLFlag)

@dynamic zl_navigationBarAdded;

- (BOOL)zl_navigationBarAdded {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZl_navigationBarAdded:(BOOL)zl_navigationBarAdded {
    objc_setAssociatedObject(self, @selector(zl_navigationBarAdded), @(zl_navigationBarAdded), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
