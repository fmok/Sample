//
//  ZLNavigationController.m
//  ZLNavigationController
//
//  Created by PatrickChow on 16/7/4.
//  Copyright © 2016年 ZhouLee. All rights reserved.
//

#import "ZLNavigationController.h"

#import <objc/runtime.h>

static CGFloat kZLNavigationControllerPushPopTransitionDuration = .315;

@interface ZLNavigationBar: UINavigationBar <UINavigationBarDelegate>
@end

@implementation ZLNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.translucent = NO;
    }
    return self;
}

- (UIBarPosition)barPosition {
    return UIBarPositionTopAttached;
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (CGSize)intrinsicContentSize {
    if (@available(iOS 11.0, *)) {
        if (self.prefersLargeTitles) {
            UIFont *largeTitleFont = self.largeTitleTextAttributes[NSFontAttributeName];
            if (largeTitleFont) {
                return CGSizeMake(0, 44 + round(largeTitleFont.lineHeight));
            }
            return CGSizeMake(0, 96);
        }
    }
    return CGSizeMake(0, 44);
}

@end


@interface ZLMaskView : UIView

@end

@implementation ZLMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFliter)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)tapFliter {}
@end

@interface UIViewController(ZLFlag)
@property (nonatomic, assign) BOOL zl_navigationBarAdded;
@end

@implementation UIViewController (ZLFlag)
@dynamic zl_navigationBarAdded;

- (BOOL)zl_navigationBarAdded {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZl_navigationBarAdded:(BOOL)zl_navigationBarAdded {
        objc_setAssociatedObject(self, @selector(zl_navigationBarAdded), @(zl_navigationBarAdded), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface ZLNavigationController()<
    UIGestureRecognizerDelegate,
    ZLViewControllerAnimatedTransitioning,
    ZLViewControllerContextTransitioning,
    CAAnimationDelegate>
{
    BOOL _isAnimationInProgress;
}
@property (nonatomic, strong, readwrite) NSArray *viewControllers;

@property (nonatomic, strong) NSMutableArray *viewControllerStack;

@property (nonatomic, weak) UIViewController *currentDisplayViewController;

@property (nonatomic, strong) ZLMaskView *transitionMaskView;

@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *interactiveGestureRecognizer;
@property (nonatomic, strong, readwrite) UIScreenEdgePanGestureRecognizer *interactiveEdgeGestureRecognizer;

@property (nonatomic, strong, readwrite) ZLPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;

@property (nonatomic, weak) id<ZLViewControllerAnimatedTransitioning> animatedTransitioning;
@property (nonatomic, weak) id<ZLViewControllerContextTransitioning> contextTransitioning;

@property (nonatomic, strong) UIView *zl_containerView;

@property (nonatomic, weak, readwrite) UIViewController *topViewController;
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

@end


@implementation ZLNavigationController

- (void)dealloc {
    self.viewControllerStack = nil;
    self.viewControllers = nil;
}

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

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = [[UIScreen mainScreen] bounds];
    
    self.zl_containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.zl_containerView.backgroundColor = [UIColor clearColor];
    self.zl_containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.zl_containerView];
    
    // 全屏侧拉
    self.interactiveGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    self.interactiveGestureRecognizer.delegate = self;
    [self.zl_containerView addGestureRecognizer:self.interactiveGestureRecognizer];
    // 边缘侧拉
    self.interactiveEdgeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    self.interactiveEdgeGestureRecognizer.edges = UIRectEdgeLeft;
    [self.zl_containerView addGestureRecognizer:self.interactiveEdgeGestureRecognizer];
    // 默认全屏侧拉
    [self setNavInteractivePopGestureType:ZLNavInteractivePopGestureTypeFullScreen];
    
    self.transitionMaskView = [[ZLMaskView alloc] initWithFrame:self.view.bounds];
    self.transitionMaskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.transitionMaskView.backgroundColor = [UIColor clearColor];
    self.transitionMaskView.hidden = YES;
    [self.zl_containerView addSubview:self.transitionMaskView];
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
    [self.zl_containerView addSubview:rootView];
    [self addNavigationBarIfNeededByViewController:rootViewController];
    [rootViewController didMoveToParentViewController:self];

}

#pragma mark - Autorotation support
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

#pragma mark Push & Pop Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated completion:nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(ZLCompletionBlock __nullable)completedBlock
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
    [self.zl_containerView addSubview:toView];
    //防止在动画的时候可以点击
    [self.zl_containerView bringSubviewToFront:self.transitionMaskView];
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

- (void)popViewControllerAnimated:(BOOL)animated completion:(ZLCompletionBlock)completedBlock {
    [self popToViewController:self.previousViewController animated:animated completion:completedBlock];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(ZLCompletionBlock)completedBlock
{
    if (!viewController) {
        return;
    }
    if (_isAnimationInProgress) {
        return;
    }
    _isAnimationInProgress = YES;
    
    [viewController beginAppearanceTransition:YES animated:YES];
    [self.zl_containerView insertSubview:viewController.view belowSubview:self.currentDisplayViewController.view];
    [self addNavigationBarIfNeededByViewController:viewController];
    self.transitionMaskView.hidden = NO;
    [self.view bringSubviewToFront:self.transitionMaskView];
    viewController.view.frame = self.zl_containerView.frame;
    
    [self.animatedTransitioning popAnimation:animated withFromViewController:self.currentDisplayViewController andToViewController:viewController completion:completedBlock];
}

#pragma mark - ZLViewControllerContextTransitioning
- (UIView *)containerView {
    return self.zl_containerView;
}

- (void)finishInteractiveTransition {
    [self setNeedsStatusBarAppearanceUpdate];
    _isAnimationInProgress = NO;
}

- (void)cancelInteractiveTransition {
    _isAnimationInProgress = NO;
}

#pragma mark - ZLViewControllerAnimatedTransitioning
- (CGFloat)transitionDuration {
    return kZLNavigationControllerPushPopTransitionDuration;
}

- (void)pushAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(ZLCompletionBlock)completedBlock {
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

- (void)popAnimation:(BOOL)animated withFromViewController:(UIViewController *)fromViewController andToViewController:(UIViewController *)toViewController completion:(ZLCompletionBlock)completedBlock {
    [self addShadowLayerIn:self.currentDisplayViewController];
    
    [self startPopAnimationWithFromViewController:fromViewController
                                 toViewController:toViewController
                                         animated:animated
                                   withCompletion:^(BOOL isCancel){
                                       if (isCancel) {
                                           [toViewController beginAppearanceTransition:NO animated:NO];
                                           [toViewController.view removeFromSuperview];
                                           [toViewController endAppearanceTransition];
                                       }else {
                                           [self.currentDisplayViewController.view removeFromSuperview];
                                           [self.currentDisplayViewController removeFromParentViewController];
                                           [toViewController endAppearanceTransition];
                                           self.currentDisplayViewController = toViewController;
                                           [self releaseViewControllersAfterPopToViewController:toViewController];
                                           
                                           [self.zl_containerView bringSubviewToFront:toViewController.view];
                                           // pop 成功，设置为默认 mainType : fullScreen
                                           [self setNavInteractivePopGestureType:ZLNavInteractivePopGestureTypeFullScreen];
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
    [toViewController.view.layer addAnimation:toAnimation forKey:@"zhoulee.transition.to"];
    
    CABasicAnimation *fromAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    fromAnimation.fromValue = @(CGRectGetWidth(self.view.frame) *.5);
    fromAnimation.toValue = @(CGRectGetWidth(self.view.frame) * 0.25);
    fromAnimation.fillMode = kCAFillModeBoth;
    fromAnimation.duration = [self.animatedTransitioning transitionDuration];
    fromAnimation.removedOnCompletion = YES;
    [fromViewController.view.layer addAnimation:fromAnimation forKey:@"zhoulee.transition.from"];
    
//    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    maskAnimation.fromValue = @(0);
//    maskAnimation.toValue = @(0);
//    maskAnimation.fillMode = kCAFillModeBoth;
//    maskAnimation.duration = [self.animatedTransitioning transitionDuration];
//    maskAnimation.removedOnCompletion = YES;
//    [self.transitionMaskView.layer addAnimation:maskAnimation forKey:@"zhoulee.transition.opacity"];
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
    [fromViewController.view.layer addAnimation:fromAnimation forKey:@"zhoulee.transition.from"];
    
    CABasicAnimation *toAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    toAnimation.fromValue = @(CGRectGetWidth(self.view.frame) * 0.25);
    toAnimation.toValue = @(CGRectGetWidth(self.view.frame) * 0.5);
    toAnimation.fillMode = kCAFillModeBoth;
    toAnimation.duration = [self.animatedTransitioning transitionDuration];
    toAnimation.removedOnCompletion = YES;
    [toViewController.view.layer addAnimation:toAnimation forKey:@"zhoulee.transition.to"];
    
//    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    maskAnimation.fromValue = @(.4f);
//    maskAnimation.toValue = @(0);
//    maskAnimation.fillMode = kCAFillModeBoth;
//    maskAnimation.duration = [self.animatedTransitioning transitionDuration];
//    maskAnimation.removedOnCompletion = YES;
//    [self.transitionMaskView.layer addAnimation:maskAnimation forKey:@"zhoulee.transition.opacity"];
}

#pragma mark - Private Method
- (void)addNavigationBarIfNeededByViewController:(UIViewController *)viewController {
    if (viewController.zl_navigationBarHidden) {
        return;
    }
    
    if (viewController.zl_navigationBarAdded) {
        return;
    }

    if (viewController.parentViewController != self) {
        return;
    }

    [viewController.zl_navigationBar pushNavigationItem:viewController.zl_navigationItem animated:NO];
    [viewController.view addSubview:viewController.zl_navigationBar];
    viewController.zl_navigationBarAdded = YES;
//    [viewController.view layoutIfNeeded];
     [self constraintNavigationBar:viewController.zl_navigationBar onViewController:viewController];
//    viewController.zl_navigationBar.frame = CGRectMake(0, 20, CGRectGetWidth(viewController.view.bounds), 44);
//        viewController.zl_navigationBar.frame = CGRectMake(0, 0, CGRectGetWidth(viewController.view.bounds), 64);
    
    
    
    
    if (viewController.zl_automaticallyAdjustsScrollViewInsets) {
        UIScrollView *firstView = viewController.view.subviews.firstObject;
        if ([firstView isKindOfClass:[UIWebView class]]) {
            firstView = ((UIWebView *)firstView).scrollView;
        }
        if ([firstView isKindOfClass:[UIScrollView class]]) {
            UIEdgeInsets contentInset = firstView.contentInset;
            CGPoint contentOffset = firstView.contentOffset;
            
            CGFloat constant = 0;
            if (@available(iOS 11.0, *)) {
                constant = viewController.zl_navigationBar.intrinsicContentSize.height;
            } else {
                constant = viewController.zl_navigationBar.intrinsicContentSize.height + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    if (self.presentingViewController && self.modalPresentationStyle == UIModalPresentationFormSheet) {
                        constant = viewController.zl_navigationBar.intrinsicContentSize.height;
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
        NSLayoutConstraint *a = [navigationBar.widthAnchor constraintEqualToAnchor:viewController.view.widthAnchor];
        NSLayoutConstraint *b = [navigationBar.centerXAnchor constraintEqualToAnchor:viewController.view.centerXAnchor constant:0];
        NSLayoutConstraint *c = [navigationBar.topAnchor constraintEqualToAnchor:safeAreaLayoutGuide.topAnchor constant:0];

        constraint = @[a, b, c];
    } else {
        NSLayoutConstraint *a = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *b = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        CGFloat constant = 0;
        constant = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (self.presentingViewController && self.modalPresentationStyle == UIModalPresentationFormSheet) {
                constant = 0;
            }
        }
        NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
        constraint = @[a, b, c];
    }
    [NSLayoutConstraint activateConstraints:constraint];
}

- (UIViewController *)rootViewController {
    return [self.viewControllerStack firstObject];
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
    }else {
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
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGFloat velocity = [recognizer velocityInView:self.view].x;
        if (percent > 0.2 || velocity > 100.0f) {
            [self.percentDrivenInteractiveTransition finishInteractiveTransition:percent];
        }else {
            [self.percentDrivenInteractiveTransition cancelInteractiveTransition:percent];
        }
    }
}
#pragma mark -
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.currentDisplayViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.currentDisplayViewController.prefersStatusBarHidden;
}

#pragma mark - Properties Getter
- (NSArray *)viewControllers {
    return [NSArray arrayWithArray:self.viewControllerStack];
}

- (UIViewController *)topViewController {
    return self.currentDisplayViewController;
}

- (ZLPercentDrivenInteractiveTransition *)percentDrivenInteractiveTransition {
    if (!_percentDrivenInteractiveTransition) {
        _percentDrivenInteractiveTransition = [[ZLPercentDrivenInteractiveTransition alloc] init];
        _percentDrivenInteractiveTransition.contextTransitioning = self;
    }
    return _percentDrivenInteractiveTransition;
}

#pragma mark - Public methods
- (void)setNavInteractivePopGestureType:(ZLNavInteractivePopGestureType)type
{
    switch (type) {
        case ZLNavInteractivePopGestureTypeScreenEdgeLeft:
        {
            self.interactiveGestureRecognizer.enabled = NO;
            self.interactiveEdgeGestureRecognizer.enabled = YES;
        }
            break;
        case ZLNavInteractivePopGestureTypeFullScreen:
        {
            self.interactiveGestureRecognizer.enabled = YES;
            self.interactiveEdgeGestureRecognizer.enabled = NO;
        }
            break;
            
        default:
            break;
    }
}

@end

#pragma mark -
@implementation UIViewController(ZLNavigationController)
@dynamic zl_navigationController,zl_automaticallyAdjustsScrollViewInsets;

- (ZLNavigationController *)zl_navigationController {
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController && ![parentViewController isKindOfClass:[ZLNavigationController class]]) {
        parentViewController = parentViewController.parentViewController;
    }
    return (ZLNavigationController *)parentViewController;
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

@implementation UIViewController(ZLNavigationBar)
- (UINavigationBar *)zl_navigationBar {
    UINavigationBar *navigationBar = objc_getAssociatedObject(self, _cmd);
    if (!navigationBar) {
        navigationBar = [[ZLNavigationBar alloc] initWithFrame:
                         CGRectZero];
//        navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        objc_setAssociatedObject(self, _cmd, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationBar;
}

- (void)setZl_navigationBar:(UINavigationBar *)zl_navigationBar {
    objc_setAssociatedObject(self, @selector(zl_navigationBar), zl_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIViewController (ZLNavigationItem)

- (UINavigationItem *)zl_navigationItem {
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

- (void)setZl_navigationItem:(UINavigationItem *)zl_navigationItem {
    objc_setAssociatedObject(self, @selector(zl_navigationItem), zl_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@interface ZLPercentDrivenInteractiveTransition()

@property (nonatomic, assign) CFTimeInterval pausedTime;

@property (nonatomic, assign) double completeSpeed;
@end

@implementation ZLPercentDrivenInteractiveTransition
- (void)startInteractiveTransition {
    [self pauseLayer:[self.contextTransitioning containerView].layer];
}

- (void)updateInteractiveTransition:(double)percentComplete {
    [self.contextTransitioning containerView].layer.timeOffset =  self.pausedTime + [self.contextTransitioning transitionDuration] * percentComplete;
}

- (void)finishInteractiveTransition:(CGFloat)percentComplete {
    [self resumeLayer:[self.contextTransitioning containerView].layer];
//    CGFloat delay = [self.contextTransitioning transitionDuration] * (1 -  percentComplete) + 0.05;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.contextTransitioning finishInteractiveTransition];
//    });
}

- (void)cancelInteractiveTransition:(double)percentComplete {
    CALayer *containerLayer = [self.contextTransitioning containerView].layer;
    containerLayer.fillMode = kCAFillModeBoth;
    
    self.completeSpeed = percentComplete>0.0?percentComplete:0.0;
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kZLNavigationControllerPushPopTransitionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [displayLink invalidate];
        containerLayer.timeOffset = 0;
        for (CALayer *subLayer in containerLayer.sublayers) {
            [subLayer removeAllAnimations];
        }
        containerLayer.speed = 1.0;
    });
}

- (void)handleDisplayLink {
    double timeOffset = [self.contextTransitioning containerView].layer.timeOffset;
    timeOffset -= self.completeSpeed/30.0;
    [self.contextTransitioning containerView].layer.timeOffset = timeOffset;
}

#pragma mark - Handle Layer
- (void)pauseLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
    self.pausedTime = pausedTime;
}

- (void)resumeLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}
@end

