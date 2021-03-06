//
//  FMRequest.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMRequest.h"
#import "JSONModel.h"
#import "SHError.h"
#import "UIDeviceHardware.h"

static NSString *const kNetworkDataParseErrorDomain = @"FMRequest.JSON.PARSE.ERROR";

@interface FMRequest()

@property (nonatomic, assign, readwrite) NSInteger responseCode;
@property (nonatomic, strong, readwrite) NSString *responseMessage;
@property (nonatomic, assign, readwrite) BOOL isCacheData;

@end

@implementation FMRequest

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - Public methods
- (void)startWithNoBack
{
    [self startWithJsonModelClass:nil success:nil failure:nil];
}

- (void)startWithJsonModelClass:(Class)modelClass
                        success:(void (^)(FMRequest *request, id modelObj))success
                        failure:(void (^)(FMRequest *request, id modelObj))failure
{
    WS(weakSelf);
    void (^SuccessBlock)(YTKBaseRequest *request) = ^(YTKBaseRequest *request) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        id obj = [weakSelf responseJSONObject];
    TTDPRINT(@"\n----------------%@-----------------\nCode:%@\nMessage:%@\n%@\n----------------------------------------\n",
             (weakSelf.responseCode==0)?@"Success":@"业务错误",
             @(weakSelf.responseCode),
             weakSelf.responseMessage,
             request);
        
        if (success) {
            if (weakSelf.responseCode != 0) {
                success((FMRequest *)request, _responseMessage);
                return ;
            }
            if (!obj) {
                if (failure) {
                    failure((FMRequest *)request, @"");
                }
                return ;
            }
            NSError *err = nil;
            JSONModel *model = nil;
            
            if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                
                @try {
                    if (modelClass) {
                        model = [(JSONModel *)[modelClass alloc] initWithDictionary:obj error:&err];
                        if (!err) {
                            _isCacheData = NO;
                        }
                    }
                } @catch (NSException *exception) {
                    err = [NSError errorWithDomain:kNetworkDataParseErrorDomain
                                              code:NetworkAPIHelperErrorCodeModelParse
                                          userInfo:@{
                                                     NSLocalizedDescriptionKey: @"JSONModel解析错误[数据类型不匹配]"
                                                     }];
                } @finally {
                    
                }
                if (err) {
                    if (failure) {
                        failure((FMRequest *)request, [SHError errorWithError:err].localizedDescription);
                    }
                } else {
                    id objModel = nil;
                    if (model) {
                        objModel = model;
                    } else {
                        objModel = obj;
                    }
                    [weakSelf responseJsonModelCompleteWithModel:objModel];
                    success((FMRequest *)request, objModel);
                }
            } else {
                [weakSelf responseJsonModelCompleteWithModel:obj];
                success((FMRequest *)request, obj);
            }
        }
    };
    
    void (^FailureBlock)(YTKBaseRequest *request) = ^(YTKBaseRequest *request) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    TTDPRINT(@"\n---------------Failure------------------\nstatusCode:%@\n%@\n----------------------------------------\n",
             @(request.response.statusCode),
             request);
        
        if (failure) {
            failure((FMRequest *)request, [SHError errorWithError:request.error].localizedDescription);
        }
    };
    // 为避免有些请求是在子线程中调用的，所以这里把 UI 操作放回主线程操作
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
    [super startWithCompletionBlockWithSuccess:SuccessBlock failure:FailureBlock];
}

- (id)cacheJsonWithModelClass:(Class)modelClass
{
    BOOL isExsitCache = [self loadCacheWithError:nil];
    
    if (!isExsitCache) {
        return nil;
    }
    
    id obj = [self responseJSONObject];
    
    NSError *err = nil;
    JSONModel *model = nil;
    //
    if (obj && [obj isKindOfClass:[NSArray class]] && !modelClass) {
        return obj;
    }
    // responseSerializerType: YTKResponseSerializerTypeJSON (application/json) (recommend)
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        if (modelClass) {
            model = [(JSONModel *)[modelClass alloc] initWithDictionary:obj error:&err];
            if (!err) {
                _isCacheData = YES;
                [self responseJsonModelCompleteWithModel:model];
            } else {
                TTDPRINT(@"JSONModel解析错误[数据类型不匹配]");
            }
        } else {
            NSDictionary *dic = (NSDictionary *)obj;
            if (dic.count > 0) {
                model = obj;
            }
        }
    }
    // responseSerializerType: YTKResponseSerializerTypeHTTP (default) (text/html or nil)
    if (!obj) {
        obj = self.responseString;
        if (obj && [obj isKindOfClass:[NSString class]]) {
            if (modelClass) {
                model = [(JSONModel *)[modelClass alloc] initWithString:obj error:&err];
                if (!err) {
                    _isCacheData = YES;
                    [self responseJsonModelCompleteWithModel:model];
                } else {
                    TTDPRINT(@"JSONModel解析错误[数据类型不匹配]");
                }
            } else {
                NSString *str = (NSString *)obj;
                if (str.length > 0) {
                    model = obj;
                }
            }
        }
    }
    
    return model;
}

- (BOOL)responseIsNormal
{
    BOOL isNormal = NO;
    if (self.responseCode == 0) {
        isNormal = YES;
    }
    return isNormal;
}

- (void)responseJsonModelCompleteWithModel:(id)model {
}

#pragma mark - Override
- (NSString *)baseUrl
{
    return kAPIBaseURL;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}
// 请求头
//- (NSDictionary *)requestHeaderFieldValueDictionary
//{
//    return @{
//             @"udid": [APPSettingManager udid],
//             @"systemVersion": [APPSettingManager osVersion],
//             @"User-Agent": [[self class] userAgent]
//             };
//}

//- (id)requestArgument
//{
//    return @{
//             @"vs" : [APPSettingManager appVersion],
//             @"userDevice" : [APPSettingManager osVersion],
//             @"iosidfa" : [APPSettingManager idfaString]
//             };
//}

#pragma mark - Private function
- (id)responseJSONObject
{
    id obj = [super responseJSONObject];
    if ([[self.response MIMEType] isEqualToString:@"text/html"]) {
        obj = [super responseString];
    }
    obj = [self responseJSONObjectFilter:obj];
    return obj;
}

/**
    过滤掉response的外层
    根据接口返回数据结构的格式修改
 */
- (id)responseJSONObjectFilter:(id)obj_
{
    id obj = nil;
    if ([obj_ isKindOfClass:[NSString class]]) {
        NSError *serializationError = nil;
        NSData *data = nil;
        NSString *resultstr = obj_;
        if (resultstr && ![resultstr isEqualToString:@" "]) {
            data = [resultstr dataUsingEncoding:NSUTF8StringEncoding];
            if (data) {
                if ([data length] > 0) {
                    obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                }
            }
        }
    } else if ([obj_ isKindOfClass:[NSDictionary class]]) {
        obj = obj_;
    }
    
    NSInteger fmCode = -1;
    NSString *message = @"";
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        id code = obj[@"error"];
        message = CHANGE_TO_STRING(obj[@"message"]);
        if ([code isKindOfClass:[NSNumber class]]) {
            fmCode = [code integerValue];
        } else if ([code isKindOfClass:[NSString class]]) {
            fmCode = [code integerValue];
        }
        // 此处注释掉，暂时全部字段返回
//        obj = obj[@"list"];
    }
    _responseCode = fmCode;
    _responseMessage = message;
    return obj;
}

+ (NSString *)userAgent
{
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; %@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [UIDeviceHardware platform]];
    return userAgent;
}

@end
