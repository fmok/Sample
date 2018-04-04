//
//  PetDetailBottomPetDesView.m
//  Sample
//
//  Created by wjy on 2018/4/4.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailBottomPetDesView.h"

@implementation PetDetailBottomPetDesView

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
