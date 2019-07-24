//
//  FMNetWorkConfigure.m
//  Sample
//
//  Created by wjy on 2019/7/24.
//  Copyright © 2019 wjy. All rights reserved.
//

#import "FMNetWorkConfigure.h"
#import "FMUrlArgumentsFilter.h"

@implementation FMNetWorkConfigure

#pragma mark - Public methods
+ (void)netWorkGlobalConfigure
{
    [self configureNewtWorkAgent];
    [self configureNetWorkUrlFilter];
}

#pragma mark - Private methods
+ (void)configureNewtWorkAgent
{
    //
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
}

+ (void)configureNetWorkUrlFilter
{
    YTKNetworkConfig *configure = [YTKNetworkConfig sharedConfig];
    FMUrlArgumentsFilter *urlFilter = [FMUrlArgumentsFilter filterWithArguments:@{
                                                                                  @"vs" : [APPSettingManager appVersion],
                                                                                  @"userDevice" : [APPSettingManager osVersion],
                                                                                  @"iosidfa" : [APPSettingManager idfaString]
                                                                                  }];
    [configure addUrlFilter:urlFilter];
}

@end
