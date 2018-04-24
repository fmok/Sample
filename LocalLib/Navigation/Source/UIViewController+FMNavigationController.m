//
//  UIViewController+FMNavigationController.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UIViewController+FMNavigationController.h"
#import <objc/runtime.h>
#import "FMNavigationController.h"

@implementation UIViewController (FMNavigationController)

@dynamic fm_navigationController,fm_automaticallyAdjustsScrollViewInsets;

- (FMNavigationController *)fm_navigationController {
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController && ![parentViewController isKindOfClass:[FMNavigationController class]]) {
        parentViewController = parentViewController.parentViewController;
    }
    return (FMNavigationController *)parentViewController;
}

- (BOOL)fm_navigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFm_navigationBarHidden:(BOOL)fm_navigationBarHidden {
    objc_setAssociatedObject(self, @selector(fm_navigationBarHidden), @(fm_navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fm_automaticallyAdjustsScrollViewInsets {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj == nil) {
        return YES;
    }
    return [obj boolValue];
}

- (void)setFm_automaticallyAdjustsScrollViewInsets:(BOOL)fm_automaticallyAdjustsScrollViewInsets {
    objc_setAssociatedObject(self, @selector(fm_automaticallyAdjustsScrollViewInsets), @(fm_automaticallyAdjustsScrollViewInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
