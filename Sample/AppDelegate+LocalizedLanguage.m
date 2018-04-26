//
//  AppDelegate+LocalizedLanguage.m
//  Sample
//
//  Created by wjy on 2018/4/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "AppDelegate+LocalizedLanguage.h"

@implementation AppDelegate (LocalizedLanguage)

- (void)configLocalizedLanguage
{
    [[LocalizedLanguageManager shareManager] configDefaultLanguageEnvironment];
}

@end
