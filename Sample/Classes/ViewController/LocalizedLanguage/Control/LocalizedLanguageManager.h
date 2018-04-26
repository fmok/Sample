//
//  LocalizedLanguageManager.h
//  Sample
//
//  Created by wjy on 2018/4/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, LocalizedLanguageType) {
    LocalizedLanguageType_zh_Hans = 1 << 0,
    LocalizedLanguageType_zh_Hant = 1 << 1,
    LocalizedLanguageType_en      = 1 << 2,
};

@interface LocalizedLanguageManager : NSObject

@property (nonatomic, assign, setter=fm_setCurrentType:) LocalizedLanguageType currentType;

+ (instancetype)shareManager;

/**
 启动应用设置默认 Language
 先取本地存储，若无，跟随系统
 */
- (void)setDefaultLanguageEnvironment;
/**
 返回 currentType 对应的 language value
 */
- (NSString *)getShowValueWithLocalizedStrKey:(NSString *)key andLanTable:(NSString *)table;

@end
