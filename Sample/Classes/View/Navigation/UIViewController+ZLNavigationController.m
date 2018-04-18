//
//  UIViewController+ZLNavigationController.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UIViewController+ZLNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (FMNavigationController)

@dynamic fm_navigationController,zl_automaticallyAdjustsScrollViewInsets;

- (FMNavigationController *)fm_navigationController {
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController && ![parentViewController isKindOfClass:[FMNavigationController class]]) {
        parentViewController = parentViewController.parentViewController;
    }
    return (FMNavigationController *)parentViewController;
}

- (BOOL)zl_navigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZl_navigationBarHidden:(BOOL)zl_navigationBarHidden {
    objc_setAssociatedObject(self, @selector(zl_navigationBarHidden), @(zl_navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zl_automaticallyAdjustsScrollViewInsets {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj == nil) {
        return YES;
    }
    return [obj boolValue];
}

- (void)setZl_automaticallyAdjustsScrollViewInsets:(BOOL)zl_automaticallyAdjustsScrollViewInsets {
    objc_setAssociatedObject(self, @selector(zl_automaticallyAdjustsScrollViewInsets), @(zl_automaticallyAdjustsScrollViewInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
