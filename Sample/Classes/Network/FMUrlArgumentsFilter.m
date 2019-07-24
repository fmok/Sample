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

#pragma mark - YTKUrlFilterProtocol
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request
{
    return [self urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

#pragma mark - Private methods
- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters
{
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    } else {
        return originUrlString;
    }
}

- (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters
{
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0) {
        for (NSString *key in parameters) {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            value = [self urlEncode:value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

- (NSString*)urlEncode:(NSString*)str
{
    return AFPercentEscapedStringFromString(str);
}

@end
