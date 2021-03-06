//
//  FMNavigationController.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMNavigationController.h"
#import <objc/runtime.h>
#import "FMNavigationBar.h"
#import "FMNavMaskView.h"
#import "UIViewController+FMFlag.h"
#import "FMPercentDrivenInteractiveTransition.h"

@interface FMNavigationController()<
    UIGestureRecognizerDelegate,
    FMViewControllerAnimatedTransitioning,
    FMViewControllerContextTransitioning,
    CAAnimationDelegate>
{
    BOOL _isAnimationInProgress;
}
@property (nonatomic, strong, readwrite) NSArray *viewControllers;
@property (nonatomic, strong) NSMutableArray *viewControllerStack;
@property (nonatomic, weak) UIViewController *currentDisplayViewController;

@property (nonatomic, strong) FMNavMaskView *transitionMaskView;

@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *interactiveGestureRecognizer;
@property (nonatomic, strong, readwrite) UIScreenEdgePanGestureRecognizer *interactiveEdgeGestureRecognizer;

@property (nonatomic, strong, readwrite) FMPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;

@property (nonatomic, weak) id<FMViewControllerAnimatedTransitioning> animatedTransitioning;
@property (nonatomic, weak) id<FMViewControllerContextTransitioning> contextTransitioning;

@property (nonatomic, strong) UIView *fm_containerView;

@property (nonatomic, weak, readwrite) UIViewController *topViewController;
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

@end


@implementation FMNavigationController

#pragma mark - Instance methods
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super init];
    if (self) {
        self.viewControllerStack = [NSMutableArray arrayWithObject:rootViewController];
        self.currentDisplayViewController = rootViewController;
        self.animatedTransitioning = self;
        self.contextTransitioning = self;
        self.rootViewController = rootViewController;
    }
    return self;
}

- (instancetype)initWithViewController:(NSArray<UIViewController *> *)viewControllers {
    self = [super init];
    if (self) {
        self.viewControllerStack = [NSMutableArray arrayWithArray:viewControllers];
        self.currentDisplayViewController = viewControllers.lastObject;
        self.animatedTransitioning = self;
        self.contextTransitioning = self;
        self.rootViewController = viewControllers.firstObject;
        
        [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addChildViewController:obj];
        }];
    }
    return self;
}

#pragma mark - Life cycle
- (void)dealloc {
    self.viewControllerStack = nil;
    self.viewControllers = nil;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = [[UIScreen mainScreen] bounds];
    
    self.fm_containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.fm_containerView.backgroundColor = [UIColor clearColor];
    self.fm_containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.fm_containerView];
    
    // 全屏侧拉
    self.interactiveGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    self.interactiveGestureRecognizer.delegate = self;
    [self.fm_containerView addGestureRecognizer:self.interactiveGestureRecognizer];
    // 边缘侧拉
    self.interactiveEdgeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    self.interactiveEdgeGestureRecognizer.edges = UIRectEdgeLeft;
    [self.fm_containerView addGestureRecognizer:self.interactiveEdgeGestureRecognizer];
    // 默认全屏侧拉
    [self setNavInteractivePopGestureType:FMNavInteractivePopGestureTypeFullScreen];
    
    self.transitionMaskView = [[FMNavMaskView alloc] initWithFrame:self.view.bounds];
    self.transitionMaskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.transitionMaskView.backgroundColor = [UIColor clearColor];
    self.transitionMaskView.hidden = YES;
    [self.fm_containerView addSubview:self.transitionMaskView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *rootViewController = self.viewControllerStack.lastObject;
    
//    [rootViewController willMoveToParentViewController:self];
    if (!rootViewController.parentViewController) {
        [self addChildViewController:rootViewController];
    }
    
    UIView *rootView = rootViewController.view;
    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.fm_containerView addSubview:rootView];
    [self addNavigationBarIfNeededByViewController:rootViewController];
    [rootViewController didMoveToParentViewController:self];

}

#pragma mark - Public methods
#pragma mark Push & Pop Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated completion:nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(FMCompletionBlock __nullable)completedBlock
{
    if (!viewController) {
        return;
    }
    if (_isAnimationInProgress) {
        return;
    }
    _isAnimationInProgress = YES;
    
    
    [self.viewControllerStack addObject:viewController];
    [self addChildViewController:viewController];
    [viewController beginAppearanceTransition:YES animated:YES];
    [viewController willMoveToParentViewController:self];
    
    UIView *toView = viewController.view;
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.fm_containerView addSubview:toView];
    //防止在动画的时候可以点击
    [self.fm_containerView bringSubviewToFront:self.transitionMaskView];
    self.transitionMaskView.hidden = NO;
    
    [self addNavigationBarIfNeededByViewController:viewController];
    [viewController didMoveToParentViewController:self];
    
    [self.animatedTransitioning pushAnimation:animated withFromViewController:self.currentDisplayViewController andToViewController:viewController completion:completedBlock];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {
    [self popToViewController:self.rootViewController animated:animated];
}

- (void)popViewControllerAnimated:(BOOL)animated {
    [self popToViewController:self.previousViewController animated:animated];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self popToViewController:viewController animated:animated completion:nil];
}

- (void)popViewControllerAnimated:(BOOL)animated completion:(FMCompletionBlock)completedBlock {
    [self popToViewController:self.previousViewController animated:animated completion:completedBlock];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(FMCompletionBlock)completedBlock
{
    if (!viewController) {
        return;
    }
    if (_isAnimationInProgress) {
        return;
    }
    _isAnimationInProgress = YES;
    
    [viewController beginAppearanceTransition:YES animated:YES];
    [self.fm_containerView insertSubview:viewController.view belowSubview:self.currentDisplayViewController.view];
    [self addNavigationBarIfNeededByViewController:viewController];
    self.transitionMaskView.hidden = NO;
    [self.view bringSubviewToFront:self.transitionMaskView];
    viewController.view.frame = self.fm_containerView.frame;
    
    [self.animatedTransitioning popAnimation:animated withFromViewController:self.currentDisplayViewController andToViewController:viewController completion:completedBlock];
}

- (void)removeViewController:(UIViewController *)viewController {
    if (viewController == self.currentDisplayViewController) {
        return;
    }
    if ([self.viewControllerStack containsObject:viewController]) {
        [self.viewControllerStack removeObject:viewController];
        [viewController removeFromParentViewController];
    }
}

#pragma mark 设置侧拉方案
- (void)setNavInteractivePopGestureType:(FMNavInteractivePopGestureType)type
{
    switch (type) {
        case FMNavInteractivePopGestureTypeScreenEdgeLeft:
        {
            self.interactiveGestureRecognizer.enabled = NO;
            self.interactiveEdgeGestureRecognizer.enabled = YES;
        }
            break;
        case FMNavInteractivePopGestureTypeFullScreen:
        {
            self.interactiveGestureRecognizer.enabled = YES;
            self.interactiveEdgeGestureRecognizer.enabled = NO;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - FMViewControllerContextTransitioning
- (UIView *)containerView {
    return self.fm_containerView;
}

- (void)finishInteractiveTransition {
    [self setNeedsStatusBarAppearanceUpdate];
    _isAnimationInProgress = NO;
}

- (void)cancelInteractiveTransition {
    _isAnimationInProgress = NO;
}

#pragma mark - FMViewControllerAnimatedTransitioning
- (CGFloat)transitionDuration {
    return kFMNavigationControllerPushPopTransitionDuration;
}

- (void)pushAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(FMCompletionBlock)completedBlock {
    [self addShadowLayerIn:toViewController];
    
    [self startPushAnimationWithFromViewController:fromViewController
                                  toViewController:toViewController
                                          animated:animated
                                    withCompletion:^(BOOL isCancel){
                                        [self.currentDisplayViewController.view removeFromSuperview];
                                        self.currentDisplayViewController = toViewController;
                                        [toViewController endAppearanceTransition];
                                        [self.contextTransitioning finishInteractiveTransition];
                                        self.transitionMaskView.hidden = YES;
                                        
                                        if (completedBlock) {
                                            completedBlock(isCancel);
                                        }
                                    }];
}

- (void)popAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(FMCompletionBlock)completedBlock {
    [self addShadowLayerIn:self.currentDisplayViewController];
    
    [self startPopAnimationWithFromViewController:fromViewController
                                 toViewController:toViewController
                                         animated:animated
                                   withCompletion:^(BOOL isCancel){
                                       if (isCancel) {
                                           [toViewController beginAppearanceTransition:NO animated:NO];
                                           [toViewController.view removeFromSuperview];
                                           [toViewController endAppearanceTransition];
                                       } else {
                                           [self.currentDisplayViewController.view removeFromSuperview];
                                           [self.currentDisplayViewController removeFromParentViewController];
                                           [toViewController endAppearanceTransition];
                                           self.currentDisplayViewController = toViewController;
                                           [self releaseViewControllersAfterPopToViewController:toViewController];
                                           
                                           [self.fm_containerView bringSubviewToFront:toViewController.view];
                                           // pop 成功，设置为默认 mainType : fullScreen
                                           [self setNavInteractivePopGestureType:FMNavInteractivePopGestureTypeFullScreen];
                                       }
                                       self.transitionMaskView.hidden = YES;
                                       [self.contextTransitioning finishInteractiveTransition];
                                       
                                       if (completedBlock) {
                                           completedBlock(isCancel);
                                       }
                                   }];
}

#pragma mark - Animation
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    void(^callback)(BOOL) = [anim valueForKeyPath:@"callback"];
    if (callback){
        callback(!flag);
        callback = nil;
    }
}

- (void)startPushAnimationWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController animated:(BOOL)animated withCompletion:(void(^)(BOOL isCancel))callback {
    if (!animated) {
        callback(NO);
        callback = nil;
        return;
    }
    CABasicAnimation *toAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    toAnimation.fromValue = @(CGRectGetWidth(self.view.frame) * 1.5);
    toAnimation.toValue = @(CGRectGetWidth(self.view.frame) * 0.5);
    toAnimation.duration = [self.animatedTransitioning transitionDuration];
    toAnimation.fillMode = kCAFillModeBoth;
    toAnimation.removedOnCompletion = YES;
    toAnimation.delegate = self;
    [toAnimation setValue:callback forKeyPath:@"callback"];
    [toViewController.view.layer addAnimation:toAnimation forKey:@"fm.transition.to"];
    
    CABasicAnimation *fromAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    fromAnimation.fromValue = @(CGRectGetWidth(self.view.frame) *.5);
    fromAnimation.toValue = @(CGRectGetWidth(self.view.frame) * 0.25);
    fromAnimation.fillMode = kCAFillModeBoth;
    fromAnimation.duration = [self.animatedTransitioning transitionDuration];
    fromAnimation.removedOnCompletion = YES;
    [fromViewController.view.layer addAnimation:fromAnimation forKey:@"fm.transition.from"];
}

- (void)startPopAnimationWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController animated:(BOOL)animated withCompletion:(void(^)(BOOL isCancel))callback {
    if (!animated) {
        callback(NO);
        callback = nil;
        return;
    }
    
    CABasicAnimation *fromAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    fromAnimation.fromValue = @(CGRectGetWidth(self.view.frame) * 0.5);
    fromAnimation.toValue = @(CGRectGetWidth(self.view.frame) * 1.5);
    fromAnimation.duration = [self.animatedTransitioning transitionDuration];
    fromAnimation.fillMode = kCAFillModeBoth;
    fromAnimation.removedOnCompletion = NO;
    fromAnimation.delegate = self;
    [fromAnimation setValue:callback forKeyPath:@"callback"];
    [fromViewController.view.layer addAnimation:fromAnimation forKey:@"fm.transition.from"];
    
    CABasicAnimation *toAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    toAnimation.fromValue = @(CGRectGetWidth(self.view.frame) * 0.25);
    toAnimation.toValue = @(CGRectGetWidth(self.view.frame) * 0.5);
    toAnimation.fillMode = kCAFillModeBoth;
    toAnimation.duration = [self.animatedTransitioning transitionDuration];
    toAnimation.removedOnCompletion = YES;
}

#pragma mark - Private Method
- (void)addNavigationBarIfNeededByViewController:(UIViewController *)viewController {
    if (viewController.fm_navigationBarHidden) {
        return;
    }
    
    if (viewController.fm_navigationBarAdded) {
        return;
    }

    if (viewController.parentViewController != self) {
        return;
    }

    [viewController.fm_navigationBar pushNavigationItem:viewController.fm_navigationItem animated:NO];
    [viewController.view addSubview:viewController.fm_navigationBar];
    viewController.fm_navigationBarAdded = YES;
//    [viewController.view layoutIfNeeded];
    [self constraintNavigationBar:viewController.fm_navigationBar onViewController:viewController];
//    viewController.fm_navigationBar.frame = CGRectMake(0, 20, CGRectGetWidth(viewController.view.bounds), 44);
//        viewController.fm_navigationBar.frame = CGRectMake(0, 0, CGRectGetWidth(viewController.view.bounds), 64);
    
    if (viewController.fm_automaticallyAdjustsScrollViewInsets) {
        UIScrollView *firstView = viewController.view.subviews.firstObject;
        if ([firstView isKindOfClass:[UIWebView class]]) {
            firstView = ((UIWebView *)firstView).scrollView;
        }
        if ([firstView isKindOfClass:[UIScrollView class]]) {
            UIEdgeInsets contentInset = firstView.contentInset;
            CGPoint contentOffset = firstView.contentOffset;
            
            CGFloat constant = 0;
            if (@available(iOS 11.0, *)) {
                constant = viewController.fm_navigationBar.intrinsicContentSize.height;
            } else {
                constant = viewController.fm_navigationBar.intrinsicContentSize.height + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    if (self.presentingViewController && self.modalPresentationStyle == UIModalPresentationFormSheet) {
                        constant = viewController.fm_navigationBar.intrinsicContentSize.height;
                    }
                }
            }
            contentInset.top += constant;
            contentOffset.y -= constant;
            [firstView setScrollIndicatorInsets:contentInset];
            [firstView setContentInset:contentInset];
            [firstView setContentOffset:contentOffset animated:NO];
        }
    }
}

- (void)constraintNavigationBar:(UINavigationBar *)navigationBar onViewController:(UIViewController *)viewController {
    navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraint;
    if (@available(iOS 11.0, *)) {
        UILayoutGuide *safeAreaLayoutGuide = viewController.view.safeAreaLayoutGuide;
        NSLayoutConstraint *width = [navigationBar.widthAnchor constraintEqualToAnchor:viewController.view.widthAnchor];
        NSLayoutConstraint *centerX = [navigationBar.centerXAnchor constraintEqualToAnchor:viewController.view.centerXAnchor constant:0];
        NSLayoutConstraint *top = [navigationBar.topAnchor constraintEqualToAnchor:safeAreaLayoutGuide.topAnchor constant:0];

        constraint = @[width, centerX, top];
    } else {
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        CGFloat constant = 0;
        constant = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (self.presentingViewController && self.modalPresentationStyle == UIModalPresentationFormSheet) {
                constant = 0;
            }
        }
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
        constraint = @[left, right, top];
    }
    [NSLayoutConstraint activateConstraints:constraint];
}

- (UIViewController *)previousViewController {
    return [self previousViewControllerByViewController:self.currentDisplayViewController];
}

- (UIViewController *)previousViewControllerByViewController:(UIViewController *)viewController {
    if (![self.viewControllerStack containsObject:viewController]) {
        return nil;
    }
    NSUInteger index = [self.viewControllerStack indexOfObject:viewController];
    if (index) {
        return [self.viewControllerStack objectAtIndex:index - 1];
    } else {
        return nil;
    }
}

- (NSUInteger)indexForViewControllerInStack:(UIViewController *)viewController {
    return [self.viewControllerStack indexOfObject:viewController];
}

- (void)releaseViewControllersAfterPopToViewController:(UIViewController *)viewController {
    NSUInteger index = [self.viewControllerStack indexOfObject:viewController];
    
    for (NSUInteger i = index + 1; i < self.viewControllerStack.count; i ++) {
        UIViewController *viewController = self.viewControllerStack[i];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }
    [self.viewControllerStack removeObjectsInRange:NSMakeRange(index+1, self.viewControllerStack.count-index-1)];
}

- (void )addShadowLayerIn:(UIViewController *)viewController {
    CALayer *shadowLayer = viewController.view.layer;
    shadowLayer.shadowOffset = CGSizeMake(-3, 0);
    shadowLayer.shadowRadius = 3.0;
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    shadowLayer.shadowOpacity = 0.2;
    shadowLayer.shadowPath = [UIBezierPath bezierPathWithRect:viewController.view.bounds].CGPath;
}


#pragma mark - Interactive Gesture Recognizer
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (_isAnimationInProgress) {
        return NO;
    }
    
    CGPoint translate = [gestureRecognizer translationInView:self.view];
    if (translate.x < 0) {
        return NO;
    }
    if (self.viewControllerStack.count == 1) {
        return NO;
    }
    
    return fabs(translate.x) > fabs(translate.y);
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)recognizer {
    CGFloat translate = [recognizer translationInView:self.view].x;
    double percent = (double)translate / (double)CGRectGetWidth(self.view.bounds);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self popViewControllerAnimated:YES];
        [self.percentDrivenInteractiveTransition startInteractiveTransition];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGFloat velocity = [recognizer velocityInView:self.view].x;
        if (percent > 0.2 || velocity > 100.0f) {
            [self.percentDrivenInteractiveTransition finishInteractiveTransition:percent];
        } else {
            [self.percentDrivenInteractiveTransition cancelInteractiveTransition:percent];
        }
    }
}

#pragma mark - Autorotation support
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - StatusBar Related
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.currentDisplayViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.currentDisplayViewController.prefersStatusBarHidden;
}

#pragma mark - Properties Getters
- (NSArray *)viewControllers {
    return [NSArray arrayWithArray:self.viewControllerStack];
}

- (UIViewController *)topViewController {
    return self.currentDisplayViewController;
}

- (UIViewController *)rootViewController {
    return [self.viewControllerStack firstObject];
}

- (FMPercentDrivenInteractiveTransition *)percentDrivenInteractiveTransition {
    if (!_percentDrivenInteractiveTransition) {
        _percentDrivenInteractiveTransition = [[FMPercentDrivenInteractiveTransition alloc] init];
        _percentDrivenInteractiveTransition.contextTransitioning = self;
    }
    return _percentDrivenInteractiveTransition;
}

@end


