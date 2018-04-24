//
//  UIViewController+FMFlag.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UIViewController+FMFlag.h"
#import <objc/runtime.h>

@implementation UIViewController (FMFlag)

@dynamic fm_navigationBarAdded;

- (BOOL)fm_navigationBarAdded {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFm_navigationBarAdded:(BOOL)fm_navigationBarAdded {
    objc_setAssociatedObject(self, @selector(fm_navigationBarAdded), @(fm_navigationBarAdded), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
