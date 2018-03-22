//
//  Control.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "Control.h"
#import "SampleListAPI.h"
#import "HUD.h"

@interface Control()
{
    SampleListAPI *refreshAPI;
}

@end

@implementation Control

#pragma mark - Public methods
- (void)testRequest
{
    refreshAPI = [[SampleListAPI alloc] init];
    [refreshAPI startWithJsonModelClass:nil success:^(FMRequest *request, id modelObj) {
        if ([request responseIsNormal]) {
            [HUD showTipWithText:request.responseJMMessage];
            TTDPRINT(@"\n%@\n", modelObj);
        } else {
            // 业务错误
            [HUD showTipWithText:request.responseJMMessage];
        }
    } failure:^(FMRequest *request, id modelObj) {
        // 网络错误
        [HUD showTipWithText:modelObj];
    }];
}

#pragma mark - Private methods

#pragma mark - 


@end
