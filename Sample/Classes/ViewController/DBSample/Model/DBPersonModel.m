//
//  DBPersonModel.m
//  Sample
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DBPersonModel.h"

@implementation DBPersonModel

+ (NSString *)jr_customPrimarykey {
    return @"personID"; // 对应property的属性名
}

- (id)jr_customPrimarykeyValue {
    return self.personID;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                       @"id": @"personID"
                                                       }];
}

@end
