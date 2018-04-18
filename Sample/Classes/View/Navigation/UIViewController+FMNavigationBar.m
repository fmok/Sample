//
//  UIViewController+ZLNavigationBar.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UIViewController+FMNavigationBar.h"
#import <objc/runtime.h>
#import "FMNavigationBar.h"

@implementation UIViewController (FMNavigationBar)

- (UINavigationBar *)fm_navigationBar {
    UINavigationBar *navigationBar = objc_getAssociatedObject(self, _cmd);
    if (!navigationBar) {
        navigationBar = [[FMNavigationBar alloc] initWithFrame:
                         CGRectZero];
//        navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        objc_setAssociatedObject(self, _cmd, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationBar;
}

- (void)setFm_navigationBar:(UINavigationBar *)fm_navigationBar {
    objc_setAssociatedObject(self, @selector(fm_navigationBar), fm_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
