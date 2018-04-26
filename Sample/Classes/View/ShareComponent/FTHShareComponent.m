//
// Created by 周东兴 on 2017/3/9.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import "FTHShareComponent.h"
#import "FTHShareComponentViewController.h"
#import "FTHShareComponentAdapter.h"

#import "SDImageCache.h"
#import "SDWebImageDownloader.h"

@interface FTHShareComponent ()
@property(nonatomic, strong, readwrite) NSArray *supportPlatforms;

@property(nonatomic) FTHSocialPlatformInstalledState installed;

@property(nonatomic, copy, readwrite) FTHShareComponentModelContext modelBlock;

@end

@implementation FTHShareComponent

- (instancetype)init {
	self = [super init];
	if (self) {
		_installed = [FTHShareComponentAdapter platformInstalledState];
	}
	return self;
}

#pragma mark - Public Methods

- (void)setupAttributes:(FTHShareComponentModelContext)modelBlock {
	self.modelBlock = modelBlock;
}

- (void)showOnTarget:(UIViewController *__weak)target {
	FTHShareComponentViewController *viewController = [[FTHShareComponentViewController alloc] init];
	viewController.component = self;
	viewController.modalPresentationStyle = UIModalPresentationCustom;
	viewController.transitioningDelegate = (id <UIViewControllerTransitioningDelegate>) viewController;
	
	self.shareComponentViewController = viewController;
	
	[target presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Private Methods

#pragma mark - Properties

- (NSArray *)supportPlatforms {
	if (_supportPlatforms == nil) {
        _supportPlatforms = @[
                              @{kFTHShareComponentBarItemTitle: @"微信好友",
                                kFTHShareComponentBarItemImage: @"share_wx_icon",
                                kFTHShareComponentBarItemType: @(FTHSocialPlatformTypeWechatSession),
                                kFTHShareComponentBarItemDisabled: @(self.installed.socialPlatformWechat)},
                              @{kFTHShareComponentBarItemTitle: @"朋友圈",
                                kFTHShareComponentBarItemImage: @"share_wxf_icon",
                                kFTHShareComponentBarItemType: @(FTHSocialPlatformTypeWechatTimeLine),
                                kFTHShareComponentBarItemDisabled: @(self.installed.socialPlatformWechatTimeLine)},
                              @{kFTHShareComponentBarItemTitle: @"微博",
                                kFTHShareComponentBarItemImage: @"share_wb_icon",
                                kFTHShareComponentBarItemType: @(FTHSocialPlatformTypeWebo),
                                kFTHShareComponentBarItemDisabled: @(self.installed.socialPlatformWebo)},
                              @{kFTHShareComponentBarItemTitle: @"QQ",
                                kFTHShareComponentBarItemImage: @"share_qq_icon",
                                kFTHShareComponentBarItemType: @(FTHSocialPlatformTypeQQ),
                                kFTHShareComponentBarItemDisabled: @(self.installed.socialPlatformQQ)},
                              @{kFTHShareComponentBarItemTitle: @"QQ空间",
                                kFTHShareComponentBarItemImage: @"share_qqz_icon",
                                kFTHShareComponentBarItemType: @(FTHSocialPlatformTypeQQZone),
                                kFTHShareComponentBarItemDisabled: @(self.installed.socialPlatformQQZone)},
                              @{kFTHShareComponentBarItemTitle: @"Safari",
                                kFTHShareComponentBarItemImage: @"share_safari_icon",
                                kFTHShareComponentBarItemType: @(FTHSocialPlatformTypeSafari),
                                kFTHShareComponentBarItemDisabled: @(YES)},
                              @{kFTHShareComponentBarItemTitle: @"更多",
                                kFTHShareComponentBarItemImage: @"share_more_icon",
                                kFTHShareComponentBarItemType: @(FTHSocialPlatformTypeSystem),
                                kFTHShareComponentBarItemDisabled: @(YES)}
                              ];
	}
	return _supportPlatforms;
}
@end

@interface FTHShareComponentModel ()

@end

@implementation FTHShareComponentModel
@synthesize title = _title;
@synthesize imageURL = _imageURL;
@synthesize abstract = _abstract;
@synthesize url = _url;
@synthesize thumbImage = _thumbImage;
@synthesize integrable = _integrable;
#pragma mark - Overrite

- (instancetype)init {
	self = [super init];
	if (self) {
		_integrable = YES;
	}
	return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
	FTHShareComponentModel *model = (FTHShareComponentModel *)[[self class] allocWithZone:zone];
	model.url = self.url;
	model.title = self.title;
	model.abstract = self.abstract;
	model.platformType = self.platformType;
	model.imageURL = self.imageURL;
	model.thumbImage = self.thumbImage;
	model.integrable = self.integrable;
	return model;
}

// 缩略图不存在时，获取默认的。
// 也可以外部指定
- (UIImage *_Nullable)thumbImage {
	if (!_thumbImage) {
		UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.imageURL];
		if (!image) {
			image = [UIImage imageNamed:@"share_app"];
		}
		_thumbImage = image;
	}
	return _thumbImage;
}

/// 先把图片下载下来
- (void)setImageURL:(NSString *)imageURL {
	_imageURL = imageURL;
	
	UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
	if (!image) {
		[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *_Nullable image, NSData *_Nullable data, NSError *_Nullable error, BOOL finished) {
			if (!error && finished) {
				[[SDImageCache sharedImageCache] storeImageDataToDisk:data forKey:imageURL];
			}
		}];
	}
}

@end
