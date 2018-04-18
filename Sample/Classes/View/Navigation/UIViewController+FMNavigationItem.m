//
//  UIViewController+FMNavigationItem.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UIViewController+FMNavigationItem.h"
#import <objc/runtime.h>

@implementation UIViewController (FMNavigationItem)

- (UINavigationItem *)fm_navigationItem {
    UINavigationItem *item = objc_getAssociatedObject(self, _cmd);
    if (!item) {
        item = [[UINavigationItem alloc] init];
        if (self.title) {
            item.title = self.title;
        }
        objc_setAssociatedObject(self, _cmd, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

- (void)setFm_navigationItem:(UINavigationItem *)fm_navigationItem {
    objc_setAssociatedObject(self, @selector(fm_navigationItem), fm_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
