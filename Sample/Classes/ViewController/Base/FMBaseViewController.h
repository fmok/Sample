//
//  FMBaseViewController.h
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMBaseViewController : UIViewController

@property (nonatomic, weak) UINavigationController *nav;

/**
 设置 navBar 背景图片
 */
- (void)configNavBarBackgroundImage:(UIImage *)image;
/**
 设置 navBar 是否为不透明（默认为：透明）
 */
- (void)configNavBarOpaque:(BOOL)isOpaque;
/**
 弹框提示
 */
- (void)showHUDTip:(NSString *)string;
/**
 navBar 约束适配iOS 11
 */
- (void)constraintNavigationBar:(UINavigationBar *)navigationBar;
/**
 */
- (void)changeNavBarTitle:(NSString *)title;

/**
 */
- (void)popVC;

@end
