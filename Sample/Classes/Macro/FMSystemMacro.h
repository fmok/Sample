//
//  FMSystemMacro.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#ifndef FMSystemMacro_h
#define FMSystemMacro_h

// 屏幕宽高
#define kScreenWidth                    ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight                   ([UIScreen mainScreen].bounds.size.height)

// 机型
#define ISIPAD                             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?YES:NO
#define ISIPHONE                           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO

#define ISIPHONE5                          [UIScreen mainScreen].bounds.size.height == 568
#define ISIPHONE6PLUS                      [UIScreen mainScreen].bounds.size.height == 736
#define ISIPHONE6                          [UIScreen mainScreen].bounds.size.height == 667
#define ISIPHONE4S                         [UIScreen mainScreen].bounds.size.height == 480
#define IS_IPHONEX                          (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)

//转换成字符串
#define CHANGE_TO_STRING(obj) (obj == nil || [obj isKindOfClass:[NSNull class]]) ? @"" : [NSString stringWithFormat:@"%@",obj]

// 当前软件版本号
#define SoftVersionString    ([[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] stringByReplacingOccurrencesOfString:@"." withString:@""])
#define kAppVersion  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kBuildVersion  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

// NSCoding
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#ifdef DEBUG

#define S_TARGET_DEBUG 1

#endif

#ifdef S_TARGET_DEBUG
#if 1
#define TTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define TTDPRINT(xx, ...)  ((void)0)
#endif
#else
#define TTDPRINT(xx, ...)  ((void)0)
#endif // #ifdef DEBUG


#endif /* FMSystemMacro_h */
