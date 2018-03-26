//
//  UIView+Utilities.m
//  SohuNews2
//
//  Created by Gao Yongyue on 13-8-28.
//  Copyright (c) 2013年 Sohu.com Inc. All rights reserved.
//

#import "UIView+Utilities.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Additions)

- (CGPoint)centerOfView
{
    CGPoint p;
    p.x = self.frame.size.width/2;
    p.y = self.frame.size.height/2;
    return p;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_left
{
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_top
{
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_right
{
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_centerX
{
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_centerX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_centerY
{
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_centerY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_width
{
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ml_height
{
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        x += view.ml_left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        y += view.ml_top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        x += view.ml_left;
        
        if ([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        y += view.ml_top;
        
        if ([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame
{
    return CGRectMake(self.screenViewX, self.screenViewY, self.ml_width, self.ml_height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)ml_origin
{
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)ml_size
{
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMl_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls
{
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews)
    {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (BOOL)isSubviewOf:(UIView *)view
{
    UIView *superView = self.superview;
    while (superView)
    {
        if (view==superView)
        {
            return YES;
        }
        superView = superView.superview;
    }
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls
{
    if ([self isKindOfClass:cls])
    {
        return self;
        
    }
    else if (self.superview)
    {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    }
    else
    {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)viewController
{
	for (UIView* next = [self superview]; next; next = next.superview)
    {
		UIResponder* nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]])
        {
			return (UIViewController*)nextResponder;
		}
	}
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////
-(void)moveByOffset:(CGOffset)offset
{
    CGPoint center = self.center;
    center.x += offset.x;
    center.y += offset.y;
    [self setCenter:center];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView
{
    return [self convertPoint:CGPointZero toView:otherView];
    /*
     CGFloat x = 0, y = 0;
     for (UIView* view = self; view && view != otherView; view = view.superview) {
     x += view.left;
     y += view.top;
     }
     return CGPointMake(x, y);
     */
}

- (BOOL )containsPoint:(CGPoint )point
{
    //    CGPoint point1 = [self convertPoint:point fromView:self.superview];
    return [self pointInside:point withEvent:nil];
}

- (BOOL )containsPoint:(CGPoint )point inView:(UIView *)view
{
    CGPoint point1 = [self convertPoint:point fromView:view];
    return [self pointInside:point1 withEvent:nil];
}

- (UIImage *)imageFromView
{
    CGSize size = self.ml_size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return image;
}
@end

