//
//  SHError.m
//  SohuNews2
//  重新统一定义错误码
//  Created by Chen Zhiqiang on 13-8-8.
//  Copyright (c) 2013年 Chen Zhiqiang. All rights reserved.
//

#import "SHError.h"

@interface SHError() {
    SHErrorCode _errorCode;
    NSString *_errorMsg;
}

+ (NSString *)codeToMsg:(SHErrorCode)code msg:(NSString*)strMsg;

@end

@implementation SHError
@synthesize errorCode = _errorCode, errorMsg = _errorMsg;

- (id)initWithError:(NSError *)err {
    self = [super init];
    if (self) {
        // NSURLErrorUnknown
        // 跟网络返回相关的
        switch(err.code) {
            case -1001: {
                // 网络链接超时
                _errorCode = error_connect_timeout;
                _errorMsg = NSLocalizedString(@"network_connect_timeout", @"");
            }
                break;
            case -1009: {
                // 网络链接错误
                _errorCode = error_network_connet;
                _errorMsg = NSLocalizedString(@"network_connet_error", @"");
            }
                break;
            case -1011:
            case -1002:
            case -1003: {
                // 请求的url不存在
                _errorCode = error_requestUrl_not_exit;
                _errorMsg = NSLocalizedString(@"request_url_not_exit", @"");
            }
                break;
            case 504:
            case 404: {
                _errorCode = error_operation_could_not_complete;
                _errorMsg = NSLocalizedString(@"operation_could_not_complete", @"");
            }
                break;
                
            default: {
                _errorCode = error_unknown;
                _errorMsg = @"";
            }
                break;
        }
    }
    
    return self;
}

- (id)initWithCode:(SHErrorCode)code msg:(NSString*)strMsg
{
    self = [super init];
    if (self)
    {
        _errorCode = code;
        _errorMsg = [SHError codeToMsg:code msg:strMsg];
    }

    return self;
}

+ (NSString *)codeToMsg:(SHErrorCode)code msg:(NSString*)strMsg
{
    NSString* strValue = nil;
    switch (code)
    {
        case error_network_connet:
            strValue = NSLocalizedString(@"network_connet_error", @"");
            break;
        default:
            break;
    }
    
    if (![FMUtility isEmptyString:strMsg]) {
        strValue = strMsg;
    }
 
    return strValue;
}

+ (NSError *)errorWithError:(NSError *)err
{
    SHError* error = [[SHError alloc] initWithError:err];
    return [NSError errorWithDomain:kErrorDomain
                        code:error.errorCode
                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:error.errorMsg, NSLocalizedDescriptionKey, nil]];
}

+ (NSError *)errorWithCode:(SHErrorCode)code msg:(NSString*)strMsg
{
    return [NSError errorWithDomain:kErrorDomain
                               code:code
                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[SHError codeToMsg:code msg:strMsg], NSLocalizedDescriptionKey, nil]];
}

@end
