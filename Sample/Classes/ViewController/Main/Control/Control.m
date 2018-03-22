//
//  Control.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "Control.h"
#import "SampleListAPI.h"

@interface Control()
{
    SampleListAPI *refreshAPI;
}

@end

@implementation Control

- (void)requestData
{
    refreshAPI = [[SampleListAPI alloc] initWithUrl:@"cate/643/" unistr:@"643"];
    [refreshAPI startWithJsonModelClass:nil success:^(FMRequest *request, id modelObj) {
        
    } failure:^(FMRequest *request, id modelObj) {
        
    }];
}


@end
