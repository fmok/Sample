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
#import "CardListModel.h"

@interface Control()
{
    SampleListAPI *refreshAPI;
}

@end

@implementation Control

#pragma mark - Public methods
- (void)testRequest
{
    WS(weakSelf);
    refreshAPI = [[SampleListAPI alloc] init];
    [refreshAPI startWithJsonModelClass:[CardListModel class] success:^(FMRequest *request, id modelObj) {
        if ([request responseIsNormal]) {
            [weakSelf serializeData:modelObj];
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
- (void)serializeData:(CardListModel *)modelObj
{
    [self.vc.cardInfoArr removeAllObjects];
    for (CardListModel *model in modelObj.list) {
        [self.vc.cardInfoArr addObject:model];
    }
    TTDPRINT(@"/n********************************/n%@/n****************************/n", self.vc.cardInfoArr);
}


#pragma mark - 


@end
