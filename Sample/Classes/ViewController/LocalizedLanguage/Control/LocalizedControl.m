//
//  LocalizedControl.m
//  Sample
//
//  Created by wjy on 2018/4/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "LocalizedControl.h"

@implementation LocalizedControl

- (void)changeLanguage:(UIButton *)sender
{
    TTDPRINT(@"%@", sender.titleLabel.text);
    NSString *showValue = nil;
    switch (sender.tag) {
        case 100:
        {
            [[LocalizedLanguageManager shareManager] fm_setCurrentType:LocalizedLanguageType_zh_Hans];
        }
            break;
        case 101:
        {
            [[LocalizedLanguageManager shareManager] fm_setCurrentType:LocalizedLanguageType_zh_Hant];
        }
            break;
        case 102:
        {
            [[LocalizedLanguageManager shareManager] fm_setCurrentType:LocalizedLanguageType_en];
        }
            break;
            
        default:
            break;
    }
    showValue = [[LocalizedLanguageManager shareManager] getShowValueWithLocalizedStrKey:@"LocalizedLanguage_testTextStr"];
    [self.vc updateTestLabel:showValue];
}

@end
