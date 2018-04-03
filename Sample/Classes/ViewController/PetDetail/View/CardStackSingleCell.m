//
//  CardStackSingleCell.m
//  Sample
//
//  Created by wjy on 2018/4/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CardStackSingleCell.h"

@implementation CardStackSingleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    }
    return self;
}

@end
