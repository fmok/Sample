//
//  HUD.h
//  BeatGuide
//
//  Created by Marin Todorov on 22/04/2012.
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

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSUInteger, MBProgressHUDType) {
    MBProgressHUDTypeRootView,
    MBProgressHUDTypeWindow,
    MBProgressHUDTypeWindowFirst
};

@interface HUD : NSObject

+(MBProgressHUD*)showUIBlockingIndicator;
+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str;
+ (MBProgressHUD *)showUIBlockingWithType:(MBProgressHUDType)type text:(NSString *)text;
+(MBProgressHUD*)showUIBlockingIndicatorWithText:(NSString*)str withTimeout:(int)seconds;

+(MBProgressHUD*)showUIBlockingProgressIndicatorWithText:(NSString*)str andProgress:(float)progress;

+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text;
+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text target:(id)t action:(SEL)sel;
+(MBProgressHUD*)showAlertWithTitle:(NSString*)titleText text:(NSString*)text target:(id)t action:(SEL)sel closeImgName:(NSString *)imgName;

+(void)hideUIBlockingIndicator;

// 默认最顶层
+ (MBProgressHUD *)showTipWithText:(NSString *)text;
+ (MBProgressHUD *)showTipWithType:(MBProgressHUDType)type text:(NSString *)text;
// 显示在哪个View上
+ (MBProgressHUD *)showUIBlockingOfView:(UIView *)view text:(NSString*)str;
+ (MBProgressHUD *)showTipOfView:(UIView *)view text:(NSString*)str;
+ (MBProgressHUD *)showFinidhTipOfView:(UIView *)view text:(NSString *)str;
+ (MBProgressHUD *)showCustomViewWithImageName:(NSString *)imgName;

// 不会多次调用回调
+ (MBProgressHUD *)showTipAutoHiddenOfView:(UIView *)view text:(NSString*)str;

+ (BOOL)isEmptyString:(NSString *)string;

//(楼市频道定制)
+ (MBProgressHUD *)showTipOfCityEn:(UIView *)view text:(NSString*)str;
@end
