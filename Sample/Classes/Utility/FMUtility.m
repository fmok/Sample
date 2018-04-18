//
//  FMUtility.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMUtility.h"
#import <CommonCrypto/CommonKeyDerivation.h>

@implementation FMUtility

+ (BOOL)isEmptyString:(NSString *)string
{
    BOOL result = NO;
    if(string == nil || [string isKindOfClass:[NSNull class]] || [string length] == 0 || [string isEqualToString:@""]) {
        result = YES;
    }
    return result;
}

+ (NSString *)refreshNameWithKey:(NSString *)key
{
    NSString *name = nil;
    if (key && [key isKindOfClass:[NSString class]]) {
        name = [FMUtility md5Hash:key];
    }
    return name;
}

+ (NSString *)md5Hash:(NSString *)content
{
    const char *str = [content UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

+ (FMNavigationController *)topNav
{
    UIViewController *topController = nil;
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (window.hidden) {
            continue;
        } else {
            topController = window.rootViewController;
            break;
        }
    }
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    if ([topController isKindOfClass:[FMNavigationController class]]) {
        return (FMNavigationController *)topController;
    }
    return nil;
}

@end
