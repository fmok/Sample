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
//        UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
//        swipeGes.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
//        [self addGestureRecognizer:swipeGes];
    }
    return self;
}

#pragma mark - UISwipeGestureRecognizer
- (void)swipeHandler:(UISwipeGestureRecognizer *)swipe
{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
