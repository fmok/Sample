//
//  UIView+Utilities.h
//  SohuNews2
//
//  Created by Gao Yongyue on 13-8-28.
//  Copyright (c) 2013年 Sohu.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGGeometryAdditions.h"
/**
 添加UIView Frame的快捷方法
 添加UIView 层次判断方法
 */
@interface UIView (Additions)

/**
 * get centerOfView
 */
@property (nonatomic,readonly) CGPoint centerOfView;

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat ml_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat ml_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat ml_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat ml_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat ml_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat ml_height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat ml_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat ml_centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint ml_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize ml_size;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (UIViewController*)viewController;

/**
 移动特定位移
 */
- (void)moveByOffset:(CGOffset)offset;

/**
 相对其他View的位置
 */
- (CGPoint)offsetFromView:(UIView*)otherView;

/**
 判断是否包含一个点（相对自己）
 */
- (BOOL )containsPoint:(CGPoint )point;

/**
 判断是否包含一个点（相对给定view）
 */
- (BOOL )containsPoint:(CGPoint )point inView:(UIView *)view;

/**
 判断是否是给定view的subView
 */
- (BOOL)isSubviewOf:(UIView *)view;

/**
 获取view内容为图片（支持高清屏，获取的image的scale为2）
 */
- (UIImage *)imageFromView;
@end
