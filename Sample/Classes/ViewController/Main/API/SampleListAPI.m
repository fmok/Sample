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
    
}

@end

@implementation SampleListAPI

//@"https://www.xxwolo.com/ccsrv/community/get_notice_list?page=0&apikey=FEE4A532A7844136BEDFAA35AA9F08D7&seed=210307647746&hash=94534067356eac3bbd004ebf2db46842&vs=7.8.18&userDevice=10.3.3&iosidfa=37D56885-83E0-4590-9189-384C8A02FE7A";
- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/%@?page=%@", kAPIBaseURL, @"community/get_notice_list", @(_page)];
}

#warning todo
/**
    由于未加入读取缓存的方法，暂时注释该方法，默认不缓存
 */
//- (NSInteger)cacheTimeInSeconds
//{
//    if (_page > 1) {
//        return -1;
//    }
//    return INT_MAX;
//}

- (id)requestArgument
{
    return @{
             @"apikey" : @"FEE4A532A7844136BEDFAA35AA9F08D7",
             @"seed" : @"210307647746",
             @"hash" : @"94534067356eac3bbd004ebf2db46842",
             @"vs" : @"7.8.18",
             @"userDevice" : @"10.3.3",
             @"iosidfa" : @"37D56885-83E0-4590-9189-384C8A02FE7A"
             };
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

#warning todo
/**
    由于当前的接口 header 的 content-type
    一部分为 text/html，一部分没有加header，所以本接口暂时重写以下方法，对于header为空的情况待验证
    对于以后新写的接口 统一 content-type 为 text/json
 */
- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeHTTP;
}

@end
