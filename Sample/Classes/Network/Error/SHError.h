//
//  SHError.h
//  SohuNews2
//  重新统一定义错误码
//  Created by Chen Zhiqiang on 13-8-8.
//  Copyright (c) 2013年 Chen Zhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kErrorDomain @"JiemianErrorDomain"

typedef enum errorCode {
    // 网络相关的定义
    error_unknown = -1,
    error_network_connet,
    error_bad_url_request,
    error_connect_timeout,
    error_connect_server,
    error_requestUrl_not_exit,
    error_operation_could_not_complete,
    error_responds_no_data,
    
}SHErrorCode;

@interface SHError : NSObject

@property (nonatomic, readonly) SHErrorCode errorCode;
@property (nonatomic, readonly) NSString *errorMsg;

- (id)initWithError:(NSError *)err;
- (id)initWithCode:(SHErrorCode)code msg:(NSString*)strMsg;

+ (NSError *)errorWithError:(NSError *)err;
+ (NSError *)errorWithCode:(SHErrorCode)code msg:(NSString*)strMsg;

@end
