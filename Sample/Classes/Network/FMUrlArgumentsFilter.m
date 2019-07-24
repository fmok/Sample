//
//  FMUrlArgumentsFilter.m
//  Sample
//
//  Created by wjy on 2019/7/24.
//  Copyright © 2019 wjy. All rights reserved.
//

#import "FMUrlArgumentsFilter.h"

@interface FMUrlArgumentsFilter()
{
    NSDictionary *_arguments;
}

@end

@implementation FMUrlArgumentsFilter

#pragma mark - Public methods
+ (FMUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments
{
    return [[self alloc] initWithArguments:arguments];
}

#pragma mark - Private methods
- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrl appendParameters:(NSDictionary *)arguments
{
    NSString *urlStr = originUrl;

    return urlStr;
}

#pragma mark - YTKUrlFilterProtocol
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request
{
    return [FMUrlArgumentsFilter urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

@end
