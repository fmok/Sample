//
//  FMAutoScrollLabel.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMAutoScrollLabel.h"

#define NUM_LABELS 2
#define LABEL_BUFFER_SPACE 30.f   // pixel buffer space between scrolling label
#define DEFAULT_PIXELS_PER_SECOND 30
#define DEFAULT_PAUSE_TIME 0.5f

@interface FMAutoScrollLabel ()
{
    UILabel *label[NUM_LABELS];
    AutoScrollDirection scrollDirection;
    CGFloat scrollSpeed;
    NSTimeInterval pauseInterval;
    CGFloat bufferSpaceBetweenLabels;
    BOOL isScrolling;
    BOOL isReCustom;
}

@end

@implementation FMAutoScrollLabel

@synthesize pauseInterval;
@synthesize bufferSpaceBetweenLabels;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    isReCustom = NO;
    for (NSInteger i = 0; i < NUM_LABELS; i++){
        label[i] = [[UILabel alloc] init];
        label[i].textColor = [UIColor whiteColor];
        label[i].backgroundColor = [UIColor clearColor];
        [self addSubview:label[i]];
    }
    
    scrollDirection = AutoScrollDirectionLeft;
    scrollSpeed = DEFAULT_PIXELS_PER_SECOND;
    pauseInterval = DEFAULT_PAUSE_TIME;
    bufferSpaceBetweenLabels = LABEL_BUFFER_SPACE;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.userInteractionEnabled = NO;
}

#pragma mark - Animation delegate
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if (isReCustom) {
        isReCustom = NO;
        return;
    }
    isScrolling = NO;
    if (/*[finished intValue] == 1 && */label[0].frame.size.width > self.frame.size.width){
        [NSTimer scheduledTimerWithTimeInterval:pauseInterval target:self selector:@selector(scroll) userInfo:nil repeats:NO];
    }
}

#pragma mark - Public methods
- (void)scroll
{
    // Prevent multiple calls
    if (isScrolling){
        //        return;
    }
    isScrolling = YES;
    
    if (scrollDirection == AutoScrollDirectionLeft){
        self.contentOffset = CGPointMake(0,0);
    } else{
        self.contentOffset = CGPointMake(label[0].frame.size.width+LABEL_BUFFER_SPACE,0);
    }
    
    [UIView beginAnimations:@"scroll1" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:label[0].frame.size.width/(float)scrollSpeed];
    
    if (scrollDirection == AutoScrollDirectionLeft){
        self.contentOffset = CGPointMake(label[0].frame.size.width+LABEL_BUFFER_SPACE,0);
    } else{
        self.contentOffset = CGPointMake(0,0);
    }
    
    [UIView commitAnimations];
}

- (void)removeAnimations
{
    [self.layer removeAllAnimations];
    for (NSInteger i = 0; i < NUM_LABELS; i++){
        label[i].text = @"";
    }
    isReCustom = YES;
    [self readjustLabels];
    
}

#pragma mark - Private methods
- (void)readjustLabels
{
    float offset = 0.0f;
    
    for (NSInteger i = 0; i < NUM_LABELS; i++){
        [label[i] sizeToFit];
        
        // Recenter label vertically within the scroll view
        CGPoint center;
        center = label[i].center;
        center.y = self.center.y - self.frame.origin.y;
        label[i].center = center;
        
        CGRect frame;
        frame = label[i].frame;
        frame.origin.x = offset;
        label[i].frame = frame;
        
        offset += label[i].frame.size.width + LABEL_BUFFER_SPACE;
    }
    
    CGSize size;
    size.width = label[0].frame.size.width + self.frame.size.width + LABEL_BUFFER_SPACE;
    size.height = self.frame.size.height;
    self.contentSize = size;
    
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    
    // If the label is bigger than the space allocated, then it should scroll
    if (label[0].frame.size.width > self.frame.size.width){
        for (NSInteger i = 1; i < NUM_LABELS; i++){
            label[i].hidden = NO;
        }
        [self scroll];
    }else{
        // Hide the other labels out of view
        for (NSInteger i = 1; i < NUM_LABELS; i++){
            label[i].hidden = YES;
        }
        // Center this label
        CGPoint center;
        center = label[0].center;
        center.x = self.center.x - self.frame.origin.x;
        label[0].center = center;
    }
}

#pragma mark - getter & setter
- (void)setText:(NSString *) text
{
    // If the text is identical, don't reset it, otherwise it causes scrolling jitter
    if ([text isEqualToString:label[0].text]){
        // But if it isn't scrolling, make it scroll
        // If the label is bigger than the space allocated, then it should scroll
        if (label[0].frame.size.width > self.frame.size.width){
            [self scroll];
        }
        return;
    }
    
    for (NSInteger i = 0; i < NUM_LABELS; i++){
        label[i].text = text;
    }
    [self readjustLabels];
}

- (NSString *)text
{
    return label[0].text;
}


- (void)setTextColor:(UIColor *)color
{
    for (NSInteger i = 0; i < NUM_LABELS; i++){
        label[i].textColor = color;
    }
}

- (UIColor *)textColor
{
    return label[0].textColor;
}


- (void)setFont:(UIFont *)font
{
    for (NSInteger i = 0; i < NUM_LABELS; i++){
        label[i].font = font;
    }
    [self readjustLabels];
}

- (UIFont *)font
{
    return label[0].font;
}


- (void)setScrollSpeed:(CGFloat)speed
{
    scrollSpeed = speed;
    [self readjustLabels];
}

- (CGFloat)scrollSpeed
{
    return scrollSpeed;
}

- (void)setScrollDirection:(AutoScrollDirection)scrollDirection
{
    scrollDirection = scrollDirection;
    [self readjustLabels];
}

- (AutoScrollDirection)scrollDirection
{
    return scrollDirection;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
