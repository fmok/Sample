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
    _result += calulator(_result);
    return self;
}

@end
