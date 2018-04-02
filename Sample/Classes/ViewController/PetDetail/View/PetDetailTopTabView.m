//
//  PetDetailTopTabView.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailTopTabView.h"

@interface PetDetailTopTabView ()


@end

@implementation PetDetailTopTabView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - Private methods
- (void)setUp
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    for (NSInteger i = 0; i < self.items.count; i++) {
        
    }
}

#pragma mark - getter & setter
- (void)setItems:(NSArray *)items
{
    _items = items;
    [self setUp];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
