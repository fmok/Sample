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

- (NSInteger)cacheTimeInSeconds
{
    if (_page > 1) {
        return -1;
    }
    return INT_MAX;
}

- (id)requestArgument
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:[super requestArgument]];
    [mdic setObject:@"FEE4A532A7844136BEDFAA35AA9F08D7" forKey:@"apikey"];
    [mdic setObject:@"210307647746" forKey:@"seed"];
    [mdic setObject:@"94534067356eac3bbd004ebf2db46842" forKey:@"hash"];
    return mdic;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

@end
