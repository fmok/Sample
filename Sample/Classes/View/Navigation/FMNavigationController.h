//
//  FMNavigationController.h
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+FMNavigationController.h"
#import "UIViewController+FMNavigationBar.h"
#import "UIViewController+FMNavigationItem.h"

@class FMPercentDrivenInteractiveTransition;
typedef void(^FMCompletionBlock)(BOOL isCancel);

typedef NS_ENUM(NSInteger, FMNavInteractivePopGestureType) {
    FMNavInteractivePopGestureTypeFullScreen,  // default
    FMNavInteractivePopGestureTypeScreenEdgeLeft
};

NS_ASSUME_NONNULL_BEGIN
@interface FMNavigationController : UIViewController

@property (nonatomic, strong, readonly) NSArray *viewControllers;
@property (nonatomic, weak, readonly) UIViewController *topViewController;
@property (nonatomic, weak, readonly) UIViewController *rootViewController;

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *interactiveGestureRecognizer;
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *interactiveEdgeGestureRecognizer;
@property (nonatomic, strong, readonly) FMPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;
- (instancetype)initWithViewController:(NSArray<UIViewController *> *)viewControllers;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(FMCompletionBlock __nullable)completedBlock;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated completion:(FMCompletionBlock)completedBlock;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;

- (void)removeViewController:(UIViewController *)viewController;
/** 侧拉方案，mainType默认为fullScreen（全屏），如有特殊页面切换为edgeLeft（边缘），需要每次进入设置 */
- (void)setNavInteractivePopGestureType:(FMNavInteractivePopGestureType)type;

@end

NS_ASSUME_NONNULL_END
