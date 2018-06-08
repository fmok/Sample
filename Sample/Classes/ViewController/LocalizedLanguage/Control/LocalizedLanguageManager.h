//
//  LocalizedLanguageManager.h
//  Sample
//
//  Created by wjy on 2018/4/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLocalizedLanguageKeyIdentifier @"kLocalizedLanguageKeyIdentifier"
#define FMLocalizedString(key)  [NSString stringWithFormat:@"%@", [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"kLocalizedLanguageKeyIdentifier"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Localized"]]

typedef NS_OPTIONS(NSInteger, LocalizedLanguageType) {
    LocalizedLanguageType_zh_Hans = 1 << 0,  // 中文简体
    LocalizedLanguageType_zh_Hant = 1 << 1,  // 中文繁体
    LocalizedLanguageType_en      = 1 << 2,  // 英语
    LocalizedLanguageType_ja_CN   = 1 << 3,  // 日本语
    LocalizedLanguageType_ko_CN   = 1 << 4,  // 韩国语
};

@interface LocalizedLanguageManager : NSObject

@property (nonatomic, assign, setter=fm_setCurrentType:) LocalizedLanguageType currentType;
@property (nonatomic, assign) BOOL isNeedSaveLanguageToLocal;  // defalut == NO

+ (instancetype)shareManager;

/**
 启动应用设置默认 Language
 先取本地存储，若无，跟随系统
 */
- (void)configDefaultLanguageEnvironment;
/**
 默认查询 table == Localized.strings
 返回 currentType 对应的 language value
 宏定义 FMLocalizedString(key) 相当于此方法
 */
- (NSString *)getShowValueWithLocalizedStrKey:(NSString *)key;
/**
 查询 table 中
 返回 currentType 对应的 language value
 */
- (NSString *)getShowValueWithLocalizedStrKey:(NSString *)key andLanTable:(NSString *)table;

@end
