//
//  LocalizedLanguageManager.m
//  Sample
//
//  Created by wjy on 2018/4/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "LocalizedLanguageManager.h"

static NSString *const LocalizedLanguage_zh_Hans = @"zh-Hans";  // 中文简体
static NSString *const LocalizedLanguage_zh_Hant = @"zh-Hant";  // 中文繁体
static NSString *const LocalizedLanguage_en = @"en";  // 英文

static NSString *const LocalizedLanguage_zh_TW = @"zh-TW";  // 台湾
static NSString *const LocalizedLanguage_zh_HK = @"zh-HK";  // 香港

static NSString *const LocalizedLanguage_ja = @"ja";  // 日本语
static NSString *const LocalizedLanguage_ko = @"ko";  // 韩国语

@implementation LocalizedLanguageManager

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static LocalizedLanguageManager *mamager = nil;
    dispatch_once(&onceToken, ^{
        mamager = [[LocalizedLanguageManager alloc] init];
        mamager.isNeedSaveLanguageToLocal = NO;
    });
    return mamager;
}

#pragma mark - Public methods
- (void)configDefaultLanguageEnvironment
{
    NSString *lan = [self getLocalLanguage];
    if (!lan) {
        lan = [self getSystemLangusge];
    }
    //
    if ([lan hasPrefix:LocalizedLanguage_zh_Hans]) {
        _currentType = LocalizedLanguageType_zh_Hans;
    } else if ([lan hasPrefix:LocalizedLanguage_zh_TW] || [lan hasPrefix:LocalizedLanguage_zh_HK] || [lan hasPrefix:LocalizedLanguage_zh_Hant]) {
        _currentType = LocalizedLanguageType_zh_Hant;
    } else if ([lan hasPrefix:LocalizedLanguage_en]) {
        _currentType = LocalizedLanguageType_en;
    } else if ([lan hasPrefix:LocalizedLanguage_ja]) {
        _currentType = LocalizedLanguageType_ja_CN;
    } else if ([lan hasPrefix:LocalizedLanguage_ko]) {
        _currentType = LocalizedLanguageType_ko_CN;
    } else {  // 默认日语
        _currentType = LocalizedLanguageType_ja_CN;
    }
    // 统一设置 中文繁体
    if ([lan hasPrefix:LocalizedLanguage_zh_TW] || [lan hasPrefix:LocalizedLanguage_zh_HK] || [lan hasPrefix:LocalizedLanguage_zh_Hant]) {
        lan = LocalizedLanguage_zh_Hant;
    }
    // 本地化
    if (lan && self.isNeedSaveLanguageToLocal) {
        [[NSUserDefaults standardUserDefaults] setObject:lan forKey:kLocalizedLanguageKeyIdentifier];
    }
}

- (NSString *)getShowValueWithLocalizedStrKey:(NSString *)key
{
    return [self getShowValueWithLocalizedStrKey:key andLanTable:@"Localized"];
}

- (NSString *)getShowValueWithLocalizedStrKey:(NSString *)key andLanTable:(NSString *)table
{
    NSString *showValue = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:[self getCurrentLanguageIdentifierStr] ofType:@"lproj"];
    // 若为韩语，也显示日语（当前为加入韩语翻译）
    if ([FMUtility isEmptyString:path] || _currentType == LocalizedLanguageType_ko_CN) {
        path = [[NSBundle mainBundle] pathForResource:LocalizedLanguage_ja ofType:@"lproj"];  // 默认 日本语
    }
    showValue = [[NSBundle bundleWithPath:path] localizedStringForKey:key value:nil table:table];
    return showValue;
}

- (void)fm_setCurrentType:(LocalizedLanguageType)currentType
{
    NSString *lan = nil;
    _currentType = currentType;
    switch (currentType) {
        case LocalizedLanguageType_zh_Hans:
        {
            lan = LocalizedLanguage_zh_Hans;
        }
            break;
        case LocalizedLanguageType_zh_Hant:
        {
            lan = LocalizedLanguage_zh_Hant;
        }
            break;
        case LocalizedLanguageType_en:
        {
            lan = LocalizedLanguage_en;
        }
            break;
        case LocalizedLanguageType_ja_CN:
        {
            lan = LocalizedLanguage_ja;
        }
            break;
        case LocalizedLanguageType_ko_CN:
        {
            lan = LocalizedLanguage_ko;
        }
            break;
        default:
            break;
    }
    if (lan && self.isNeedSaveLanguageToLocal) {
         [[NSUserDefaults standardUserDefaults] setObject:lan forKey:kLocalizedLanguageKeyIdentifier];
    }
}

#pragma mark - Private methods
- (NSString *)getCurrentLanguageIdentifierStr
{
    switch (_currentType) {
        case LocalizedLanguageType_zh_Hans:
            return LocalizedLanguage_zh_Hans;
            break;
        case LocalizedLanguageType_zh_Hant:
            return LocalizedLanguage_zh_Hant;
            break;
        case LocalizedLanguageType_en:
            return LocalizedLanguage_en;
            break;
        case LocalizedLanguageType_ja_CN:
            return LocalizedLanguage_ja;
            break;
        case LocalizedLanguageType_ko_CN:
            return LocalizedLanguage_ko;
            break;
        default:
            return LocalizedLanguage_zh_Hans;
            break;
    }
}

#pragma mark - getter & setter
- (NSString *)getLocalLanguage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLocalizedLanguageKeyIdentifier];
}

- (NSString *)getSystemLangusge
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *language = [languages firstObject];
    return language;
}

@end
