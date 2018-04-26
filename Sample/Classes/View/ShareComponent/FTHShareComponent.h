//
// Created by 周东兴 on 2017/3/9.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import "FTHShareComponentDefines.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FTHShareComponentModel <NSObject>
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * _Nullable imageURL;

@property(nonatomic, copy) NSString * _Nullable abstract;
@property(nonatomic, copy) NSString * _Nullable url;
@property(nonatomic, strong) UIImage * _Nullable thumbImage;

@property(nonatomic, assign) BOOL integrable;   // 是否可以积分，默认是YES
@end

@interface FTHShareComponentModel : NSObject <FTHShareComponentModel, NSCopying>
@property(nonatomic, assign) FTHSocialPlatformType platformType;

@end

/* @brief 模型的上下文，
 * @param model: 模型实例
 *
 * @remark model 遵守 FTHShareComponentModel 协议，用于填充分享实例
 */
typedef void (^FTHShareComponentModelContext)(id <FTHShareComponentModel> model);

@class FTHShareComponentAdapter, FTHShareComponentViewController;

@interface FTHShareComponent : NSObject
// 分享的主控制器
@property(nonatomic, weak, readwrite) FTHShareComponentViewController * shareComponentViewController;
// 支持的平台
@property(nonatomic, strong, readonly) NSArray *supportPlatforms;
//
@property(nonatomic, copy, readonly) FTHShareComponentModelContext modelBlock;
// 分享
@property(nonatomic, copy) FTHShareComponentViewContext mainViewContext;
// 微博编辑页面的上下文，可以实现自定义控件的颜色
@property(nonatomic, copy) FTHShareComponentEditViewContext editViewContext;
// 控件显示为夜间模式
@property(nonatomic, assign, getter=isDisplayNightMode) BOOL displayNightMode;

- (void)showOnTarget:(UIViewController *__weak)target;

- (void)setupAttributes:(FTHShareComponentModelContext)modelBlock;
@end

NS_ASSUME_NONNULL_END



