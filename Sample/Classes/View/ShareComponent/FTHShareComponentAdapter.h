//
// Created by 周东兴 on 2017/4/7.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FTHShareComponent.h"

typedef void (^ShareComponentShareComplete)(NSString *result, NSError *error);

@interface FTHShareComponentAdapter : NSObject

+ (FTHSocialPlatformInstalledState)platformInstalledState;

+ (void)shareTo:(FTHSocialPlatformType)platform
      withModel:(FTHShareComponentModel *)shareComponentModel
       complete:(ShareComponentShareComplete)complete;

@end