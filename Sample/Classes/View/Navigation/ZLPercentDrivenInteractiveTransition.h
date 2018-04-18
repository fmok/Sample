//
//  ZLPercentDrivenInteractiveTransition.h
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat kZLNavigationControllerPushPopTransitionDuration = .315;

NS_ASSUME_NONNULL_BEGIN
@protocol ZLViewControllerAnimatedTransitioning <NSObject>
@required
- (CGFloat)transitionDuration;
- (void)pushAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(ZLCompletionBlock)completedBlock;

- (void)popAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(ZLCompletionBlock)completedBlock;
@end

@protocol ZLViewControllerContextTransitioning <NSObject>
@required
- (UIView *)containerView;
- (CGFloat)transitionDuration;
- (void)finishInteractiveTransition;
- (void)cancelInteractiveTransition;
@end

@interface ZLPercentDrivenInteractiveTransition : NSObject

@property (nonatomic, weak) id<ZLViewControllerContextTransitioning> contextTransitioning;

- (void)startInteractiveTransition;
- (void)updateInteractiveTransition:(double)percentComplete;
- (void)finishInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition:(double)percentComplete;

@end
NS_ASSUME_NONNULL_END
