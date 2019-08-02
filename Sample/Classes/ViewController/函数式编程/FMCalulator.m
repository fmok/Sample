//
//  FMCalulator.m
//  Sample
//
//  Created by wjy on 2019/8/2.
//  Copyright © 2019 wjy. All rights reserved.
//

#import "FMCalulator.h"

@implementation FMCalulator

- (FMCalulator *)caculator:(NSInteger (^)(NSInteger result))calulator
{
    if (_result == 0) {
        _result += calulator(_result);
    } else {
        _result = calulator(_result);
    }
    return self;
}

@end
