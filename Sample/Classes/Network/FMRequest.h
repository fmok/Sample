//
//  FMRequest.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

/**
 *  Some Error
 *  Response data parse error
 */
typedef NS_ENUM(NSInteger, NetworkAPIHelperErrorCode) {
    NetworkAPIHelperErrorCodeNone = 8000,  // 未知错误
    NetworkAPIHelperErrorCodeModelParse,  // JSOMModel解析错误
};

@interface FMRequest : YTKRequest

@property (nonatomic, assign, readonly) NSInteger responseJMCode;
@property (nonatomic, strong, readonly) NSString *responseJMMessage;
@property (nonatomic, assign, readonly) BOOL isCacheData;

// 适合无返回要求的请求
- (void)startWithNoBack;

- (void)startWithJsonModelClass:(Class)modelClass
                        success:(void (^)(FMRequest *request, id modelObj))success
                        failure:(void (^)(FMRequest *request, id modelObj))failure;

- (id)cacheJsonWithModelClass:(Class)modelClass;

// 处理完成jsonModel后的回调，用于在request类里处理逻辑
// 子类需要时，需重写
- (void)responseJsonModelCompleteWithModel:(id)model;

/**
 *  request业务是否正常
 *
 *  @return Bool
 */
- (BOOL)responseIsNormal;
+ (NSString *)userAgent;

@end
