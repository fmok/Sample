//
//  HUD.m
//  BeatGuide
//
// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2011 Marin Todorov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "HUD.h"
#import "QuartzCore/QuartzCore.h"

static UIView* lastViewWithHUD = nil;

@interface GlowButton : UIButton <MBProgressHUDDelegate>

@end

@implementation GlowButton
{
    NSTimer* timer;
    float glowDelta;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //effect
        self.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1,1);
        self.layer.shadowOpacity = 0.9;
        
        glowDelta = 0.2;
        timer = [NSTimer timerWithTimeInterval:0.05
                                        target:self
                                      selector:@selector(glow)
                                      userInfo:nil
                                       repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

-(void)glow
{
    if (self.layer.shadowRadius>7.0 || self.layer.shadowRadius<0.1) {
        glowDelta *= -1;
    }
    self.layer.shadowRadius += glowDelta;
}

-(void)dealloc
{
    [timer invalidate];
    timer = nil;
}

@end

@implementation HUD

+(UIView*)rootView
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;   //从alert 点击事件里之行的HUD,获取的keywindow为alert层的UIAlertShimPresentingViewController，这里判断一下，重新给window赋值
    if ([NSStringFromClass(window.class) containsString:@"UIAlert"]) {
        window = [UIApplication sharedApplication].windows[0];
    }
    UIViewController *topController = window.rootViewController;
    
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
        
    return topController.view;
}

+ (UIWindow *)systemKeyboardWindow
{
//    UIWindow *keyboardWindow = nil;
//    for (UIWindow *window in [[UIApplication sharedApplication] windows])
//    {
//        if ([NSStringFromClass([window class]) isEqualToString:@"UITextEffectsWindow"] && !window.hidden)
//        {
//            keyboardWindow = window;
//            break;
//        }
//    }
    UIWindow *keyboardWindow = [[[UIApplication sharedApplication] windows] lastObject];
    return keyboardWindow;
}

+ (UIView *)systemContainerWindow
{
    //    UIWindow *keyboardWindow = nil;
    //    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    //    {
    //        if ([NSStringFromClass([window class]) isEqualToString:@"UITextEffectsWindow"] && !window.hidden)
    //        {
    //            keyboardWindow = window;
    //            break;
    //        }
    //    }
    int count = (int)[[[[UIApplication sharedApplication] keyWindow] subviews] count];
    UIView *window = nil;
    for (int i = count - 1; i >= 0; i --) {
        UIView *view = [[[UIApplication sharedApplication] keyWindow] subviews][i];
        if (!view.hidden && view.alpha) {
            window = view;
        }
    }
    return window;
}

+(MBProgressHUD*)showUIBlockingIndicator
{
    return [self showUIBlockingIndicatorWithText:nil];
}

+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str
{
    // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //show the HUD
    [HUD hideUIBlockingIndicator];
    UIView* targetView = [self rootView];
    if (targetView==nil) return nil;

    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
	if (str!=nil) {
        hud.labelText = str;
    } else {
        hud.labelText = @"Loading...";
    }
    
    return hud;
}


+ (MBProgressHUD *)showUIBlockingWithType:(MBProgressHUDType)type text:(NSString *)text
{
    [HUD hideUIBlockingIndicator];
    UIView *targetView = nil;
    switch (type) {
        case MBProgressHUDTypeRootView:
        {
            targetView = [self rootView];
        }
            break;
        case MBProgressHUDTypeWindow:
        {
            targetView = [self systemKeyboardWindow];
        }
            break;
        case MBProgressHUDTypeWindowFirst:
        {
            targetView = [self systemContainerWindow];
        }
        default:
            break;
    }
    
    if (targetView==nil || [HUD isEmptyString:text]) return nil;
    
    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    
    if (text!=nil) {
        hud.labelText = text;
    } else {
        hud.labelText = @"Loading...";
    }
    
    return hud;
}





+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str withTimeout:(int)seconds
{
    MBProgressHUD* hud = [self showUIBlockingIndicatorWithText:str];
    // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    hud.customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,37,37)];
    hud.mode = MBProgressHUDModeDeterminate;
    [hud hide:YES afterDelay:seconds];
    return hud;
}

+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text
{
    return [self showAlertWithTitle:titleText text:text target:nil action:NULL];
}

+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text target:(id)t action:(SEL)sel
{
    return [self showAlertWithTitle:titleText text:text target:nil action:sel closeImgName:@"btnCheck.png"];
}

+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text target:(id)t action:(SEL)sel closeImgName:(NSString *)imgName
{
    [HUD hideUIBlockingIndicator];
    
    //show the HUD
    UIView* targetView = [self rootView];
    if (targetView==nil) return nil;
    
    lastViewWithHUD = targetView;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    
    //set the text
    hud.labelText = titleText;
    hud.detailsLabelText = text;
    
    //set the close button
    GlowButton* btnClose = [GlowButton buttonWithType:UIButtonTypeCustom];
    if (t!=nil && sel!=NULL) {
        [btnClose addTarget:t action:sel forControlEvents:UIControlEventTouchUpInside];
    } else {
        [btnClose addTarget:hud action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImage* imgClose = [UIImage imageNamed:imgName];
    [btnClose setImage:imgClose forState:UIControlStateNormal];
    [btnClose setFrame:CGRectMake(0,0,imgClose.size.width,imgClose.size.height)];
    
    //hud settings
    hud.customView = btnClose;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    
    return hud;    
}

+(void)hideUIBlockingIndicator
{
    [MBProgressHUD hideHUDForView:lastViewWithHUD animated:YES];
    // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


+(MBProgressHUD*)showUIBlockingProgressIndicatorWithText:(NSString*)str andProgress:(float)progress
{
    [HUD hideUIBlockingIndicator];
    
    //show the HUD
    UIView* targetView = [self rootView];
    if (targetView==nil) return nil;
    
    lastViewWithHUD = targetView;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    
    //set the text
    hud.labelText = str;

    hud.mode = MBProgressHUDModeDeterminate;
    hud.progress = progress;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (MBProgressHUD *)showTipWithText:(NSString *)text
{
    return [self showTipWithType:MBProgressHUDTypeRootView text:text];
}

+ (MBProgressHUD *)showTipWithType:(MBProgressHUDType)type text:(NSString *)text
{
    [HUD hideUIBlockingIndicator];
    UIView *targetView = nil;
    switch (type) {
        case MBProgressHUDTypeRootView:
        {
            targetView = [self rootView];
        }
            break;
        case MBProgressHUDTypeWindow:
        {
            targetView = [self systemKeyboardWindow];
        }
            break;
        case MBProgressHUDTypeWindowFirst:
        {
            targetView = [self systemContainerWindow];
        }
        default:
            break;
    }
    
    if (targetView==nil || [HUD isEmptyString:text]) return nil;
    
    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.transform = CGAffineTransformIdentity;
    hud.userInteractionEnabled = NO;
    hud.minSize = CGSizeMake(140.f, 60.f);
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = hud.labelFont;
    hud.detailsLabelText = text;
    [hud hide:YES afterDelay:2];
    
    return hud;
}

+(MBProgressHUD*)showUIBlockingOfView:(UIView *)view text:(NSString*)str
{
    [HUD hideUIBlockingIndicator];
    // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //show the HUD
    UIView* targetView = view;
    if (targetView==nil) return nil;
    
    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    if (str!=nil) {
        hud.labelText = str;
    } else {
        hud.labelText = @"加载中...";
    }
    
    return hud;
}

+ (MBProgressHUD *)showTipOfView:(UIView *)view text:(NSString*)str
{
    [HUD hideUIBlockingIndicator];
    // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //show the HUD
    UIView* targetView = view;
    if (targetView==nil || [HUD isEmptyString:str]) return nil;
    
    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:NO];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.transform = CGAffineTransformIdentity;
    hud.userInteractionEnabled = NO;
    hud.minSize = CGSizeMake(140.f, 60.f);
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = hud.labelFont;
    hud.detailsLabelText = str;
    [hud hide:YES afterDelay:2];
    
    return hud;
}

+ (MBProgressHUD *)showFinidhTipOfView:(UIView *)view text:(NSString *)str
{
    [HUD hideUIBlockingIndicator];
    //show the HUD
    UIView* targetView = view;
    if (targetView==nil || [HUD isEmptyString:str]) return nil;
    
    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:NO];
    
    GlowButton* btnClose = [GlowButton buttonWithType:UIButtonTypeCustom];
    
    UIImage* imgClose = [UIImage imageNamed:@"btnCheck"];
    [btnClose setImage:imgClose forState:UIControlStateNormal];
    [btnClose setFrame:CGRectMake(0,0,imgClose.size.width,imgClose.size.height)];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.transform = CGAffineTransformIdentity;
    hud.userInteractionEnabled = NO;
    hud.minSize = CGSizeMake(140.f, 60.f);
//    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = hud.labelFont;
    hud.detailsLabelText = str;
    [hud hide:YES afterDelay:2];
    hud.customView = btnClose;
    hud.mode = MBProgressHUDModeCustomView;
//    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (MBProgressHUD *)showCustomViewWithImageName:(NSString *)imgName
{
    [HUD hideUIBlockingIndicator];
    
    //show the HUD
    UIView* targetView = [self systemKeyboardWindow];
    if (targetView==nil || [HUD isEmptyString:imgName]) return nil;
    
    lastViewWithHUD = targetView;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    
    //set the close button
    GlowButton* btnClose = [GlowButton buttonWithType:UIButtonTypeCustom];
    
    UIImage* imgClose = [UIImage imageNamed:imgName];
    [btnClose setImage:imgClose forState:UIControlStateNormal];
    [btnClose setFrame:CGRectMake(0,0,imgClose.size.width,imgClose.size.height)];
    
    //hud settings
    hud.customView = btnClose;
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor clearColor];
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:2];
    
    return hud;
}

+ (MBProgressHUD *)showTipAutoHiddenOfView:(UIView *)view text:(NSString*)str
{
    // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //show the HUD
    UIView* targetView = view;
    if (targetView==nil || [HUD isEmptyString:str]) return nil;
    
    lastViewWithHUD = targetView;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.transform = CGAffineTransformIdentity;
    hud.userInteractionEnabled = NO;
    hud.minSize = CGSizeMake(140.f, 60.f);
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = hud.labelFont;
    hud.detailsLabelText = str;
    [hud hide:YES afterDelay:2];
    
    return hud;
}

+ (BOOL)isEmptyString:(NSString *)string
{
    BOOL result = NO;
    //    if (![string isKindOfClass:[NSString class]]) {
    //        result = YES;
    //    } else
    
    if(string == nil || [string isKindOfClass:[NSNull class]] || [string length] == 0 || [string isEqualToString:@""]) {
        result = YES;
    }
    return result;
}
//(楼市频道定制)
+ (MBProgressHUD *)showTipOfCityEn:(UIView *)view text:(NSString*)str
{
    [HUD hideUIBlockingIndicator];
    // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //show the HUD
    UIView* targetView = view;
    if (targetView==nil || [HUD isEmptyString:str]) return nil;
    
    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:NO];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.transform = CGAffineTransformIdentity;
    hud.userInteractionEnabled = NO;
    hud.minSize = CGSizeMake(109.f, 109.f);
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [UIFont systemFontOfSize:51.f];
    hud.detailsLabelText = str;
    hud.detailsLabelColor = SRGBCOLOR_HEX(0xffffff);
    [hud hide:YES afterDelay:2];
    
    return hud;
}

@end
