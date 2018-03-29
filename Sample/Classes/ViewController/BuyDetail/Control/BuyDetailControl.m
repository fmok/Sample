//
//  BuyDetailControl.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "BuyDetailControl.h"
#import "FMAlertView.h"

@implementation BuyDetailControl

#pragma mark - Public methods
- (void)loadData
{
    [self serializeData];
}

- (void)buyCardAction
{
    TTDPRINT(@"buy card");
    FMAlertView *alert = [[FMAlertView alloc] initWithStyle:AlertStyleConfirmAlert width:0.8];
    [alert setTitleText:@"当前价格: 500LUK" contentText:@"每位用户在该卡牌预售期仅能持有一张" confirmBtnText:@"确认购买" cancelBtnText:@"取消"];
    alert.confirm = ^(){
        TTDPRINT(@"Confirm");
    };
    alert.cancel = ^(){
        TTDPRINT(@"Cancel");
    };
    [alert show];
}

#pragma mark - Private methods
- (void)serializeData
{
    [self.vc.cardView updateContentWithCardImgUrl:@"" cost:@"100.001"];
}

@end
