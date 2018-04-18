//
//  FMPercentDrivenInteractiveTransition.h
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat kFMNavigationControllerPushPopTransitionDuration = .315;

NS_ASSUME_NONNULL_BEGIN
@protocol FMViewControllerAnimatedTransitioning <NSObject>
@required
- (CGFloat)transitionDuration;
- (void)pushAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(FMCompletionBlock)completedBlock;

- (void)popAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(FMCompletionBlock)completedBlock;
@end

@protocol FMViewControllerContextTransitioning <NSObject>
@required
- (UIView *)containerView;
- (CGFloat)transitionDuration;
- (void)finishInteractiveTransition;
- (void)cancelInteractiveTransition;
@end

@interface FMPercentDrivenInteractiveTransition : NSObject

@property (nonatomic, weak) id<FMViewControllerContextTransitioning> contextTransitioning;

- (void)startInteractiveTransition;
- (void)updateInteractiveTransition:(double)percentComplete;
- (void)finishInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition:(double)percentComplete;

@end
NS_ASSUME_NONNULL_END
