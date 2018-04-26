//
// Created by 周东兴 on 2017/4/7.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import "FTHShareComponentAdapter.h"

#import <UMSocialCore/UMSocialManager.h>
#import "UMSocialCore/UMSocialImageUtil.h"
#import "UMSocialCore/UMSocialMessageObject.h"
#import "UMSocialCore/UMSocialManager.h"
#import "UMSocialCore/UMSocialResponse.h"
#import "WXApi.h"

#import "UIImage+Resize.h"

@protocol ShareComponentModelConvertible <NSObject>
- (UMSocialMessageObject *)umSMObject;
@end

@interface FTHShareComponentModel (UMObject) <ShareComponentModelConvertible>
@end

@implementation FTHShareComponentModel(UMObject)
- (UMSocialMessageObject *)umSMObject {
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    if (self.platformType == FTHSocialPlatformTypeWebo) { //新浪微博用图文分享类型
        messageObject.text = [NSString stringWithFormat:@"%@%@%@ %@", self.title, kFTHShareComponentDefaultSinaSuffix, self.abstract, self.url];
        // 图片包装
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        shareObject.shareImage = self.thumbImage;
        messageObject.shareObject = shareObject;
    } else { // 其他类型分享用网页分享类型
        //裁剪图片到 200 * 200
        UIImage *thumImage = self.thumbImage;
    
        thumImage = [thumImage imageByScalingAndCroppingForSize:CGSizeMake(200, 200)];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.title
                                                                                 descr:self.abstract
                                                                             thumImage:thumImage];
        //设置网页地址
        shareObject.webpageUrl = self.url;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    return messageObject;
}
@end

@interface FTHShareComponentAdapter ()
@end

@implementation FTHShareComponentAdapter

#pragma mark - Public Methods

+ (FTHSocialPlatformInstalledState)platformInstalledState {
    FTHSocialPlatformInstalledState installed;
    memset(&installed, 0, sizeof(installed));

    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
        installed.socialPlatformQQ = 1;
        installed.socialPlatformQQZone = 1;
    }
    if ([WXApi isWXAppInstalled]) {
        installed.socialPlatformWechat = 1;
        installed.socialPlatformWechatTimeLine = 1;
    }
    
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
        installed.socialPlatformWebo = 1;
    }
    
    return installed;
}

+ (void)shareTo:(FTHSocialPlatformType)platform
      withModel:(FTHShareComponentModel *)shareComponentModel
       complete:(ShareComponentShareComplete)complete {
    //
    UMSocialManager *manager = [UMSocialManager defaultManager];
    [manager shareToPlatform:(UMSocialPlatformType) platform
               messageObject:shareComponentModel.umSMObject
       currentViewController:nil
                  completion:^(id result, NSError *error) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          if (result && [result isKindOfClass:[UMSocialResponse class]]) {
                              if (complete) {
                                  complete(@"分享成功", nil);
                              }
                          } else {
                              if (complete) {
                                  complete(@"分享失败", error);
                              }
                          }
                      });
                  }];
}

@end
