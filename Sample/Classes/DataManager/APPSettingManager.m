//
//  APPSettingManager.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "APPSettingManager.h"
#import "SvUDIDTools.h"

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

@end
