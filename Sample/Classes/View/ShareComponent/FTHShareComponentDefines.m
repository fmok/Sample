//
//  FTHShareComponentDefines.m
//  news
//
//  Created by malei on 2017/6/20.
//  Copyright © 2017年 malei. All rights reserved.
//

#import "FTHShareComponentDefines.h"

NSString *const kFTHShareComponentBarItemTitle = @"title";
NSString *const kFTHShareComponentBarItemImage = @"image";
NSString *const kFTHShareComponentBarItemDisabled = @"disabled";
NSString *const kFTHShareComponentBarItemType = @"type";

inline NSString *FTHShareComponentForTitle(NSString *_Nullable key, NSString *_Nullable title)
{
    // key存在时:界面·key | title
    // key不存在时:title
    
    if (!title) {
        return @"";
    }
    
    if (!key || ![key length]) {
        return title;
    }
    
    return [NSString stringWithFormat:@"%@%@%@%@", kFTHShareComponentDefaultPrefix, key, kFTHShareComponentDefaultSeparator, title];
}

inline NSString *FTHShareComponentForRecmdTitle(NSString *_Nullable key, NSString *_Nullable title)
{
    // 特殊：推荐《专辑名称》 | 界面·音频
    if (!title) {
        return @"";
    }
    if (!key || ![key length]) {
        return title;
    }
    return [NSString stringWithFormat:@"推荐《%@》%@%@%@", title, kFTHShareComponentDefaultSeparator, kFTHShareComponentDefaultPrefix, key];
}
