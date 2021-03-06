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

@property (nonatomic, assign, readonly) NSInteger responseCode;
@property (nonatomic, strong, readonly) NSString *responseMessage;
@property (nonatomic, assign, readonly) BOOL isCacheData;

/**
 注：若传入modelClass，返回即为该model类型；若不传modelClass，返回为NSDictionary或NSString
 */
- (void)startWithNoBack;
- (void)startWithJsonModelClass:(Class)modelClass
                        success:(void (^)(FMRequest *request, id modelObj))success
                        failure:(void (^)(FMRequest *request, id modelObj))failure;
- (id)cacheJsonWithModelClass:(Class)modelClass;

/**
 处理完成jsonModel后的回调，用于在request类里处理逻辑
 子类需要时，需重写
 */
- (void)responseJsonModelCompleteWithModel:(id)model;

/*
 errorCode == 0
 **/
- (BOOL)responseIsNormal;

/**
 */
+ (NSString *)userAgent;

@end
