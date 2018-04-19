//
//  PetDetailFeedButton.m
//  Sample
//
//  Created by wjy on 2018/4/19.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailFeedButton.h"

#define A_DURATION (arc4random()%4+2)

@interface PetDetailFeedButton()<CAAnimationDelegate>
@end

@implementation PetDetailFeedButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)didMoveToWindow
{
    [self addFeedButtonWaveAnimation];
}

#pragma mark - Public methods
- (void)feedButtonShakeAnimation
{
    self.userInteractionEnabled = NO;
    [self.layer removeAllAnimations];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.3;
    animation.keyTimes = @[@(0),@(0.3),@(0.75),@(0.875),@(1)];
    animation.values = @[@(1),@(1.3),@(0.8),@(1.1),@(1)];
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.layer addAnimation:animation forKey:@"shakeAnimation"];
}

#pragma mark - Private methods
- (void)addFeedButtonWaveAnimation
{
    [self.layer removeAllAnimations];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.repeatCount = MAXFLOAT;
    pathAnimation.autoreverses = YES;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = A_DURATION;
    pathAnimation.removedOnCompletion = NO;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.frame, self.frame.size.width/2-5, self.frame.size.width/2-5)];
    pathAnimation.path = path.CGPath;
    [self.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    CAKeyframeAnimation *scaleX=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.values = @[@1.0, @1.2, @1.0];
    scaleX.keyTimes = @[@0.0, @0.5,@1.0];
    scaleX.repeatCount = MAXFLOAT;
    scaleX.autoreverses = YES;
    scaleX.duration = A_DURATION;
    scaleX.removedOnCompletion = NO;
    [self.layer addAnimation:scaleX forKey:@"scaleX"];
    
    CAKeyframeAnimation *scaleY=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.values = @[@1.0, @1.2, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5,@1.0];
    scaleY.repeatCount = MAXFLOAT;
    scaleY.autoreverses = YES;
    scaleY.duration = A_DURATION;
    scaleY.removedOnCompletion = NO;
    [self.layer addAnimation:scaleY forKey:@"scaleY"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self addFeedButtonWaveAnimation];
    self.userInteractionEnabled = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
