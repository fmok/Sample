//
//  FMAlertView.h
//  Sample
//
//  Created by wjy on 2018/3/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

/**
 弹窗类型
 - SimpleAlert: 简单样式   无按钮
 - ConfirmAlert: 只有一个确认按钮的 弹窗样式
 - CancelAndConfirmAlert: 有两个按钮的弹窗样式
 */
typedef NS_ENUM(NSInteger,AlertStyle) {
    SimpleAlert = 0,
    ConfirmAlert,
    CancelAndConfirmAlert
};

@interface FMAlertView : UIView

@property (nonatomic, copy) void(^confirm)(void);
@property (nonatomic, copy) void(^cancel)(void);

@property (nonatomic,assign) UIColor *confirmBackgroundColor;

/**
 点击背景是否可关闭弹窗
 */
@property (nonatomic,assign) BOOL isClickBackgroundCloseWindow;

- (instancetype)initWithStyle:(AlertStyle)style;
- (instancetype)initWithStyle:(AlertStyle)style width:(CGFloat)width;

- (void)setTitleText:(NSString *)title contentText:(NSString *)content confirmBtnText:(NSString *)confirmText cancelBtnText:(NSString *)cancelText;

- (void)show;

@end
