//
//  FMScrollLabel.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMScrollLabel.h"

static NSInteger const NumOfLabels = 2;
static double const gapBetweenLabels = 30.f;
static double const RateOfScreenRefresh = 60.f;
static double const pauseTime = .5f;

@interface FMScrollLabel ()
{
    CADisplayLink *displayLink;
    UILabel *labels[NumOfLabels];
    double stepDistance;
    double totalDistance;
}

@end

@implementation FMScrollLabel

@synthesize text = _text;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

#pragma mark - Public methods
- (void)commitInitWithBackgroundColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont
{
    self.backgroundColor = bgColor;
    for (NSInteger i = 0; i < NumOfLabels; i++) {
        labels[i] = [[UILabel alloc] init];
        labels[i].backgroundColor = [UIColor clearColor];
        labels[i].textColor = textColor;
        labels[i].font = textFont;
        [self addSubview:labels[i]];
    }
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.userInteractionEnabled = NO;
}

#pragma mark - Private methods
- (void)addTimer
{
    if (!displayLink) {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink)];
//        displayLink.frameInterval = 2;
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    if (displayLink.isPaused) {
        [displayLink setPaused:NO];
    }
}

- (void)removeTimer
{
    [displayLink invalidate];
    displayLink = nil;
}

- (void)commitInit
{
    [self commitInitWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:17.f]];
}

- (void)installConfigation
{
    double offset = 0.f;
    for (NSInteger i = 0; i < NumOfLabels; i++){
        [labels[i] sizeToFit];
        
        // Recenter label vertically within the scroll view
        CGPoint center;
        center = labels[i].center;
        center.y = self.center.y - self.frame.origin.y;
        labels[i].center = center;

        CGRect frame;
        frame = labels[i].frame;
        frame.origin.x = offset;
        labels[i].frame = frame;
        offset += labels[i].frame.size.width + gapBetweenLabels;
    }
    
    CGSize size;
    size.width = labels[0].frame.size.width + self.frame.size.width + gapBetweenLabels;
    size.height = self.frame.size.height;
    self.contentSize = size;

    [self setContentOffset:CGPointMake(0,0) animated:NO];
    
    stepDistance = (labels[0].frame.size.width+gapBetweenLabels)/(RateOfScreenRefresh);
    totalDistance = 0;
    for (NSInteger i = 1; i < NumOfLabels; i++) {
        totalDistance += labels[i].frame.size.width + gapBetweenLabels;
    }

    // If the label is bigger than the space allocated, then it should scroll
    if (labels[0].frame.size.width > self.frame.size.width){
        for (NSInteger i = 1; i < NumOfLabels; i++){
            labels[i].hidden = NO;
        }
    } else {
        // Hide the other labels out of view
        for (NSInteger i = 1; i < NumOfLabels; i++){
            labels[i].hidden = YES;
        }
        // Center this label
        CGPoint center;
        center = labels[0].center;
        center.x = self.center.x - self.frame.origin.x;
        labels[0].center = center;
    }
}

#pragma mark - Animation
- (void)beginAnimation
{
    [self addTimer];
}

- (void)pauseAnimation
{
    if (!displayLink.isPaused) {
        [displayLink setPaused:YES];
    }
}

#pragma mark - Events
- (void)handleDisplayLink
{
    self.contentOffset = CGPointMake(stepDistance,0);
    stepDistance++;
    if (stepDistance >= totalDistance) {
        stepDistance = 0;
        @autoreleasepool {
            UILabel *tmpLabel = labels[0];
            labels[0] = labels[NumOfLabels-1];
            labels[NumOfLabels-1] = tmpLabel;
        }
    }
}

#pragma mark - getter & setter
- (void)setText:(NSString *)text
{
    _text = text;
    for (NSInteger i = 0; i < NumOfLabels; i++) {
        labels[i].text = _text;
    }
    [self installConfigation];
    if (labels[0].frame.size.width > self.frame.size.width) {
        [self pauseAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(pauseTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self beginAnimation];
        });

    }
}

- (NSString *)text
{
    return _text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
