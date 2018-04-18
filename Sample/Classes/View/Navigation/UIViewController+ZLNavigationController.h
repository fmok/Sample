//
//  UIViewController+ZLNavigationController.h
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLNavigationController;

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (ZLNavigationController)

@property (nonatomic, weak, readonly) ZLNavigationController *zl_navigationController;
@property (nonatomic, assign) BOOL zl_navigationBarHidden;
@property (nonatomic, assign) BOOL zl_automaticallyAdjustsScrollViewInsets;

@end
NS_ASSUME_NONNULL_END
