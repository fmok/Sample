//
// Created by 周东兴 on 2017/3/8.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import "FTHShareComponentViewController.h"

#import "FTHShareComponentToolbar.h"
#import "FTHShareComponentEditView.h"

#import "FTHShareComponent.h"
#import "FTHShareComponentAdapter.h"

#import "HUD.h"
//#import "JMIntegralManager.h"

@interface FTHShareComponentViewController ()
        <UIViewControllerAnimatedTransitioning,
        UIViewControllerTransitioningDelegate,
        CAAnimationDelegate,
        FTHShareComponentTransmit> {

}
@property(nonatomic, weak) NSLayoutConstraint *editViewConstraint;
@property(nonatomic, strong) FTHShareComponentToolbar *toolbar;

@property(nonatomic, strong) FTHShareComponentModel *shareModel;
@end

@implementation FTHShareComponentViewController

- (void)dealloc {
    TTDPRINT(@"released %@", NSStringFromClass(self.class));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView {
    self.view = [[UIControl alloc] init];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.view.frame = [[UIScreen mainScreen] bounds];
    [((UIControl *) self.view) addTarget:self
                                  action:@selector(didPressBackground)
                        forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.shareModel = [[FTHShareComponentModel alloc] init];
    self.component.modelBlock(self.shareModel);

    FTHShareComponentViewContext context = self.component.mainViewContext;
    BOOL isDisplayNightMode = self.component.isDisplayNightMode;
    if (!context) {
        context = ^(UIView *backgroundView, NSArray<UIButton *> *shareButtons) {
            if (isDisplayNightMode) {
                backgroundView.backgroundColor = [UIColor colorWithRed:63.f / 255 green:63.f / 255 blue:63.f / 255 alpha:1];
                for (int i = 0; i < shareButtons.count; ++i) {
                    UIButton *item = shareButtons[i];
                    [item setTitleColor:[UIColor colorWithRed:136.f / 255 green:136.f / 255 blue:136.f / 255 alpha:1] forState:UIControlStateNormal];
                }
            } else {
                backgroundView.backgroundColor = [UIColor colorWithRed:245.f / 255 green:245.f / 255 blue:245.f / 255 alpha:1];
                for (int i = 0; i < shareButtons.count; ++i) {
                    UIButton *item = shareButtons[i];
                    [item setTitleColor:[UIColor colorWithRed:85.f / 255 green:85.f / 255 blue:85.f / 255 alpha:1] forState:UIControlStateNormal];
                }
            }
        };
    }

    self.toolbar = [[FTHShareComponentToolbar alloc] initWithItems:self.component.supportPlatforms];
    self.toolbar.shareViewContext = context;

    [self.view addSubview:self.toolbar];
    [self updateViewsConstraint];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [self.toolbar startAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Target Methods

- (void)didPressBackground {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];

    NSValue *aValue = userInfo[UIKeyboardFrameEndUserInfoKey];

    CGRect keyboardRect = [aValue CGRectValue];

    NSNumber *animationDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = [animationDurationValue doubleValue];

    NSUInteger animationOption = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];

    self.editViewConstraint.constant = 0;

    [UIView animateWithDuration:animationDuration delay:0.00f options:(UIViewAnimationOptions) animationOption animations:^{
        self.editViewConstraint.constant = -CGRectGetHeight(keyboardRect);
        [self.view layoutIfNeeded];
    }                completion:NULL];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];

    NSNumber *animationDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = [animationDurationValue doubleValue];

    NSUInteger animationOption = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];

    [UIView animateWithDuration:animationDuration delay:0.00f options:(UIViewAnimationOptions) animationOption animations:^{
        self.editViewConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }                completion:NULL];
}

#pragma mark - Private Methods

- (void)presentEditView {
    self.toolbar.hidden = YES;

    FTHShareComponentEditView *editView = [[FTHShareComponentEditView alloc] initWithFrame:CGRectZero];

    FTHShareComponentEditViewContext context = self.component.editViewContext;
    BOOL isDisplayNightMode = self.component.isDisplayNightMode;
    if (!context) {
        context = ^(UIView *background,
                UILabel *textLabel,
                UIView *container,
                UITextView *textView,
                UIButton *submit,
                UIButton *cancel) {
            if (isDisplayNightMode) {
                textView.keyboardAppearance = UIKeyboardAppearanceDark;
                textView.textColor = [UIColor whiteColor];
                background.backgroundColor = [UIColor colorWithRed:63.f / 250 green:63.f / 255 blue:63.f / 255 alpha:1];
                container.backgroundColor = [UIColor colorWithWhite:85.f / 255 alpha:1];
                [submit setTitleColor:[UIColor colorWithRed:201.f / 255 green:201.f / 255 blue:201.f / 255 alpha:1] forState:UIControlStateNormal];
                [submit setTitleColor:[UIColor colorWithRed:201.f / 255 green:201.f / 255 blue:201.f / 255 alpha:0.6] forState:UIControlStateDisabled];
                [submit setBackgroundImage:[[UIImage imageNamed:@"share_background_night"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateNormal];
                [cancel setBackgroundImage:[[UIImage imageNamed:@"share_background_night"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateNormal];
                [cancel setTitleColor:[UIColor colorWithRed:201.f / 255 green:201.f / 255 blue:201.f / 255 alpha:1] forState:UIControlStateNormal];
            } else {
                background.backgroundColor = [UIColor colorWithRed:245.f / 250 green:245.f / 255 blue:245.f / 255 alpha:1];\
                textView.textColor = [UIColor darkGrayColor];
                container.backgroundColor = [UIColor whiteColor];
                [submit setBackgroundImage:[[UIImage imageNamed:@"share_background"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateNormal];
                [submit setTitleColor:[UIColor colorWithRed:1.f / 255 green:87.f / 255 blue:115.f / 255 alpha:1] forState:UIControlStateNormal];
                [submit setTitleColor:[UIColor colorWithRed:201.f / 255 green:201.f / 255 blue:201.f / 255 alpha:1] forState:UIControlStateDisabled];
                [cancel setTitleColor:[UIColor colorWithRed:1.f / 255 green:87.f / 255 blue:115.f / 255 alpha:1] forState:UIControlStateNormal];
                [cancel setBackgroundImage:[[UIImage imageNamed:@"share_background"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateNormal];
            }
        };
    }

    editView.context = context;
    FTHShareComponentModel *model = [self.shareModel copy];

//    model.title = [NSString stringWithFormat:@"【%@%@】%@", self.shareModel.title, kFTHShareCompoentDefaultSuffix, @"(来自@界面)"];
    [editView setDefaultText:model.title];

    [self.view addSubview:editView];
    [self updateEditViewConstraints:editView];

    [editView beginEdit];
}

- (void)presentSystemShareView {
    // Array of times that will be shared (the ones create above)
    if ([FMUtility isEmptyString:self.shareModel.url] || [FMUtility isEmptyString:self.shareModel.title]) {
        return;
    }
	
	UIViewController *target = self.presentingViewController;
	
	if (!target) {
		target = [FMUtility topNav];
	}
	
    NSURL *shareUrl = [NSURL URLWithString:self.shareModel.url];
    NSString *shareMessage = self.shareModel.title;
    NSArray *shareItems;
    shareItems = @[shareMessage, shareUrl];
    // Opens up an ActivityView
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:shareItems
                                                                                         applicationActivities:nil];

    activityViewController.excludedActivityTypes = @[
            UIActivityTypePrint,
            UIActivityTypeCopyToPasteboard,
            UIActivityTypeAssignToContact,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToWeibo,
            UIActivityTypeSaveToCameraRoll
    ];
    activityViewController.completionWithItemsHandler =  ^(UIActivityType __nullable activityType,
            BOOL completed,
            NSArray * __nullable returnedItems,
            NSError * __nullable activityError) {
        if (completed) {
            [target dismissViewControllerAnimated:YES completion:nil];
        }
    };

    if ([activityViewController respondsToSelector:@selector(popoverPresentationController)]) {

        UIView *v = self.toolbar;
        if ([v isKindOfClass:[UIView class]]) {
            activityViewController.popoverPresentationController.sourceView = v;
            activityViewController.popoverPresentationController.sourceRect = v.bounds;
        }
    }
	
	[self dismissSelf:^{
		[target presentViewController:activityViewController animated:YES completion:nil];
	}];
}

- (void)shareTo:(FTHSocialPlatformType)type {
    // 重复分享的时候，希望model都是独立的,所以先copy
    FTHShareComponentModel *model = [self.shareModel copy];

    [self shareTo:type withModel:model];
}

- (void)shareTo:(FTHSocialPlatformType)type withModel:(FTHShareComponentModel *)model {
    model.platformType = type;
    
    ShareComponentShareComplete complete = ^(NSString *result, NSError *error) {
        if (error) {
            [self alertWithError:error];
        } else {
            if (model.integrable) {
//                [[JMIntegralManager manager] postAddIntegralWithType:JMSendIntegralTypeShare andTypeID:@""];
            }
            [HUD showTipOfView:[FMUtility topNav].view text:result];
        }
    };
    
    [self dismissSelf: ^{
        [FTHShareComponentAdapter shareTo:type withModel:model complete:complete];
    }];
}

- (void)alertWithError:(NSError *)error {
    NSString *message = @"";
    switch (error.code) {
        case UMSocialPlatformErrorType_Cancel:
            message = @"取消分享";
            break;
        case UMSocialPlatformErrorType_AuthorizeFailed:
            message = @"认证失败";
            break;
        case UMSocialPlatformErrorType_NotNetWork:
            message = @"网络链接错误";
            break;
        default:
            message = @"分享失败";
            break;
    }
    [HUD showTipWithText:message];
//    [HUD showTipOfView:self.view text:message];
}

- (void)dismissSelf:(void (^ __nullable)(void))completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

#pragma mark - ShareComponentTransmit

- (void)transmitNotInstalled:(FTHSocialPlatformType)type {
    NSString *item = @"";
    switch (type) {
        case FTHSocialPlatformTypeWebo:
            item = @"未安装微博";
            break;
        case FTHSocialPlatformTypeQQ:
        case FTHSocialPlatformTypeQQZone:
            item = @"未安装QQ";
            break;
        case FTHSocialPlatformTypeWechatSession:
        case FTHSocialPlatformTypeWechatTimeLine:
            item = @"未安装微信";
            break;
        case FTHSocialPlatformTypeSafari:
        case FTHSocialPlatformTypeSystem:
            break;
    }
    
    [HUD showTipOfView:self.view text:item];
}

- (void)transmit:(FTHSocialPlatformType)type {
    switch (type) {
        case FTHSocialPlatformTypeWebo:
//        { //微博需要弹出编辑页面
//            [self presentEditView];
//        }
//            break;
        case FTHSocialPlatformTypeQQ:
        case FTHSocialPlatformTypeQQZone:
        case FTHSocialPlatformTypeWechatSession:
        case FTHSocialPlatformTypeWechatTimeLine: {
            [self shareTo:type];
        }
            break;
        case FTHSocialPlatformTypeSafari:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.shareModel.url]];
        }
            break;
        case FTHSocialPlatformTypeSystem:
        {
            [self presentSystemShareView];
        }
            break;
    }
}

- (void)transmitWeiboEdit:(BOOL)cancel text:(NSString *)text {
    if (cancel) {

    } else {
        self.shareModel.title = text;
        [self shareTo:FTHSocialPlatformTypeWebo withModel:self.shareModel];
    }
}

#pragma mark - Layout

- (void)updateEditViewConstraints:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    [array addObject:[NSLayoutConstraint constraintWithItem:view
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:0
                                                 multiplier:1.0
                                                   constant:170]];
    [array addObject:[NSLayoutConstraint constraintWithItem:view
                                                  attribute:NSLayoutAttributeLeft
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0
                                                   constant:0]];
    [array addObject:[NSLayoutConstraint constraintWithItem:view
                                                  attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeRight
                                                 multiplier:1.0
                                                   constant:0]];
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0];
    [array addObject:layoutConstraint];
    self.editViewConstraint = layoutConstraint;
    [NSLayoutConstraint activateConstraints:array];

    [self.view layoutIfNeeded];

}

- (void)updateViewsConstraint {
    self.toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    UIEdgeInsets insets = fm_safeAreaInset(self.presentingViewController.view);
    CGFloat height = 225.f + insets.bottom;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.toolbar
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:0
                                                 multiplier:1.0
                                                   constant:height]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.toolbar
                                                  attribute:NSLayoutAttributeLeft
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0
                                                   constant:0]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.toolbar
                                                  attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeRight
                                                 multiplier:1.0
                                                   constant:0]];

    [array addObject:[NSLayoutConstraint constraintWithItem:self.toolbar
                                                  attribute:NSLayoutAttributeBottom
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeBottom
                                                 multiplier:1.0
                                                   constant:0]];

    [NSLayoutConstraint activateConstraints:array];

//    [self.view layoutIfNeeded];
}

#pragma mark -

///
///  评论页弹出动画
///  弹出效果是默认的presented效果，但是这里重新处理，主要是期望两个视图都不移除
///
#pragma mark - UIViewControllerAnimatedTransitioning

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.225;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.isBeingPresented) {
        [[transitionContext containerView] addSubview:self.view];

        [transitionContext completeTransition:YES];

        return;
    }
    if (self.isBeingDismissed) {
        CABasicAnimation *toAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        toAnimation.fromValue = @0.5;
        toAnimation.toValue = @0;
        toAnimation.duration = [self transitionDuration:transitionContext];;
        toAnimation.fillMode = kCAFillModeBoth;
        toAnimation.removedOnCompletion = NO;
        toAnimation.delegate = self;

        void (^callback)(void) = ^{
            [transitionContext completeTransition:YES];
            [self.view.layer removeAnimationForKey:@"zhoulee.transition.opacity"];
        };

        [toAnimation setValue:callback forKeyPath:@"callback"];
        [self.view.layer addAnimation:toAnimation forKey:@"zhoulee.transition.opacity"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    void (^callback)(void) = [anim valueForKeyPath:@"callback"];
    if (callback) {
        callback();
        callback = nil;
    }
}
@end
