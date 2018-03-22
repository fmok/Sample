//
//  FMUtility.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMUtility.h"

@implementation FMUtility

+ (BOOL)isEmptyString:(NSString *)string
{
    BOOL result = NO;
    if(string == nil || [string isKindOfClass:[NSNull class]] || [string length] == 0 || [string isEqualToString:@""]) {
        result = YES;
    }
    return result;
}


@end
