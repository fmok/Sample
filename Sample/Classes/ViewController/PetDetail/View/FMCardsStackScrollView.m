//
//  FMCardsStackScrollView.m
//  Sample
//
//  Created by wjy on 2018/4/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCardsStackScrollView.h"

@implementation FMCardsStackScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesHandler:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

#pragma mark - UISwipeGestureRecognizer
- (void)panGesHandler:(UIPanGestureRecognizer *)pan
{
    CGFloat translate = [pan translationInView:self].x;
    TTDPRINT(@"\n*** %@ ***\n", @(translate));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
