//
//  LocalizedLanguageManager.m
//  Sample
//
//  Created by wjy on 2018/4/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "LocalizedLanguageManager.h"

static NSString *const kLocalizedLanguageKeyIdentifier = @"kLocalizedLanguageKeyIdentifier";
static NSString *const LocalizedLanguage_zh_Hans = @"zh-Hans";
static NSString *const LocalizedLanguage_zh_Hant = @"zh-Hant";
static NSString *const LocalizedLanguage_zh_TW = @"zh-TW";
static NSString *const LocalizedLanguage_zh_HK = @"zh-HK";
static NSString *const LocalizedLanguage_en = @"en";

@implementation LocalizedLanguageManager

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static LocalizedLanguageManager *mamager = nil;
    dispatch_once(&onceToken, ^{
        mamager = [[LocalizedLanguageManager alloc] init];
    });
    return mamager;
}

#pragma mark - Public methods
- (void)setDefaultLanguageEnvironment
{
    NSString *lan = [self getLocalLanguage];
    if (!lan) {
        lan = [self getSystemLangusge];
    }
    
    if ([lan hasPrefix:LocalizedLanguage_zh_Hans]) {
        _currentType = LocalizedLanguageType_zh_Hans;
    } else if ([lan hasPrefix:LocalizedLanguage_zh_TW] || [lan hasPrefix:LocalizedLanguage_zh_HK] || [lan hasPrefix:LocalizedLanguage_zh_Hant]) {
        _currentType = LocalizedLanguageType_zh_Hant;
    } else if ([lan hasPrefix:LocalizedLanguage_en]) {
        _currentType = LocalizedLanguageType_en;
    } else{
        _currentType = LocalizedLanguageType_zh_Hans;
    }
}

- (NSString *)getShowValueWithLocalizedStrKey:(NSString *)key andLanTable:(NSString *)table
{
    NSString *showValue = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:[self getCurrentLanguageIdentifierStr] ofType:@"lproj"];
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
            
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:lan forKey:kLocalizedLanguageKeyIdentifier];
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
