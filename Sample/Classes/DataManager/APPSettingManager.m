//
//  APPSettingManager.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "APPSettingManager.h"
#import "SvUDIDTools.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation APPSettingManager

+ (NSString *)udid
{
    return [SvUDIDTools UDID];
}

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ? : [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey];
}

+ (NSString *)osVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)idfaString
{
    return [self getIdentifierForAdvertising];
}

#pragma mark 获取广告idfa
+ (NSString *)getIdentifierForAdvertising{
    if (NSClassFromString(@"ASIdentifierManager")){
        return [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    }
    return @"00000000-0000-0000-0000-000000000000";
}

@end
