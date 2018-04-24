//
//  FMPercentDrivenInteractiveTransition.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMPercentDrivenInteractiveTransition.h"

@interface FMPercentDrivenInteractiveTransition()

@property (nonatomic, assign) CFTimeInterval pausedTime;
@property (nonatomic, assign) double completeSpeed;

@end

@implementation FMPercentDrivenInteractiveTransition

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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kFMNavigationControllerPushPopTransitionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
