//
//  SampleListAPI.m
//  Sample
//
//  Created by wjy on 2018/3/22.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "SampleListAPI.h"

@interface SampleListAPI()
{
    NSString *_channelUrl;
    NSString *_unistr;
}

@end

@implementation SampleListAPI

- (instancetype)initWithUrl:(NSString *)url unistr:(NSString *)unistr
{
    self = [super init];
    if(self){
        _channelUrl = url;
        _lastTime = @"0";
        _page = 1;
        _unistr = unistr;
    }
    return self;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@%@/%@.json", _channelUrl, [FMUtility isEmptyString:_lastTime] ? @"0" :_lastTime, @(_page)];
}

- (NSInteger)cacheTimeInSeconds
{
    if (_page > 1) {
        return -1;
    }
    return INT_MAX;
}

- (id)requestArgument
{
    return nil;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

@end
