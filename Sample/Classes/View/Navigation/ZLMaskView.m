//
//  ZLMaskView.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "ZLMaskView.h"

@implementation ZLMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFliter)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)tapFliter {}

@end
