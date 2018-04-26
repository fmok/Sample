//
//  ShareComponentDefines.h
//  ShareComponent_Sample
//
//  Created by 周东兴 on 2017/4/7.
//  Copyright © 2017年 JIEMIAN. All rights reserved.
//

#ifndef ShareComponentDefines_h
#define ShareComponentDefines_h

#import "UIKit/UIKit.h"
#import <UMSocialCore/UMSocialPlatformConfig.h>

///
static NSString * const kFTHShareComponentDefaultSinaSuffix = @"（来自@界面）";
static NSString * const kFTHShareComponentDefaultPrefix = @"界面 · ";
static NSString * const kFTHShareComponentDefaultSeparator = @" | ";
static NSString * const kFTHShareComponentTypeAudio = @"音频";
static NSString * const kFTHShareComponentTypeVideo = @"视频";
static NSString * const kFTHShareComponentTypeLive  = @"直播";
static NSString * const kFTHShareComponentTypeAlbum = @"专题";

UIKIT_EXTERN NSString *FTHShareComponentForTitle(NSString *key, NSString *title);
UIKIT_EXTERN NSString *FTHShareComponentForRecmdTitle(NSString *key, NSString *title);

///
UIKIT_EXTERN NSString * const kFTHShareComponentBarItemTitle;
UIKIT_EXTERN NSString * const kFTHShareComponentBarItemImage;
UIKIT_EXTERN NSString * const kFTHShareComponentBarItemDisabled;
UIKIT_EXTERN NSString * const kFTHShareComponentBarItemType;

/*
 *  社交平台的安装情况
 */
typedef struct _SocialPlatformInstalledState {
    unsigned int socialPlatformQQ:1;
    unsigned int socialPlatformQQZone:1;
    unsigned int socialPlatformWechat:1;
    unsigned int socialPlatformWechatTimeLine:1;
    unsigned int socialPlatformWebo:1;
} FTHSocialPlatformInstalledState;

/*
 *  社交平台类型，对应UM中的UMSocialPlatformType
 */
typedef NS_ENUM(NSInteger,FTHSocialPlatformType) {
    FTHSocialPlatformTypeQQ = UMSocialPlatformType_QQ,
    FTHSocialPlatformTypeQQZone = UMSocialPlatformType_Qzone,
    FTHSocialPlatformTypeWechatSession = UMSocialPlatformType_WechatSession,
    FTHSocialPlatformTypeWechatTimeLine = UMSocialPlatformType_WechatTimeLine,
    FTHSocialPlatformTypeWebo = UMSocialPlatformType_Sina,
    FTHSocialPlatformTypeSafari = 1998,
    FTHSocialPlatformTypeSystem = 1999
};

/* @brief 分享
 * @param backgroundView：背景
 * @param textLabel：     提示文字
 * @param button：        提交按钮
 * @param textView：      输入框
 *
 * @remark (1)该block在创建评论视图时候被调用
 *         (2)vc 会默认实现该block ,需要自定义可在组件中赋值
 *
 */
typedef void (^FTHShareComponentViewContext)(UIView *backgroundView, NSArray<UIButton *> *shareButtons);

/* @brief 微博编辑页面的上下文
 * @param background:    背景
 * @param container:     编辑框背景
 * @param textView:      编辑框
 * @param textLabel:     提示文字
 * @param submit:        提交按钮
 * @param cancel:        取消按钮
 *
 * @remark (1)该block在创建编辑视图时候被调用
 *         (2)ShareComponentVC 会默认实现该block ,需要自定义可在组件中赋值
 *
 */
typedef void (^FTHShareComponentEditViewContext) (UIView *background,
                                                  UILabel *textLabel,
                                                  UIView *container,
                                                  UITextView *textView,
                                                  UIButton *submit,
                                                  UIButton *cancel);

@protocol FTHShareComponentTransmit <NSObject>
@optional
- (void)transmit:(FTHSocialPlatformType)type;

- (void)transmitNotInstalled:(FTHSocialPlatformType)type;

- (void)transmitWeiboEdit:(BOOL)cancel text:(NSString *)text;

@end

#endif /* ShareComponentDefines_h */
