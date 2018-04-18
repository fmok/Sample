//
//  UIImageView+RoundCorner.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UIImageView+RoundCorner.h"

@implementation UIImageView (RoundCorner)

- (UIImageView *)roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    self.layer.mask = layer;
    return self;
}

@end
