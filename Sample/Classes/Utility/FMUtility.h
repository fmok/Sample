//
//  FMUtility.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMNavigationController.h"

@interface FMUtility : NSObject

+ (BOOL)isEmptyString:(NSString *)string;
+ (NSString *)md5Hash:(NSString *)content;
+ (NSString *)refreshNameWithKey:(NSString *)key;

+ (FMNavigationController *)topNav;

@end
