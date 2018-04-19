//
//  MeControl.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeControl.h"
#import "TestViewController.h"
#import "FMAlertView.h"
#import "MyPurchaseViewController.h"
#import "FMH5ViewController_wk.h"
#import "UITableViewCell+showAnimaiton.h"

static NSString *const kMeCellReusedIdentifierStr = @"kMeCellReusedIdentifierStr";

@implementation MeControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.mePulledTableView registerClass:[MeCell class] forCellReuseIdentifier:kMeCellReusedIdentifierStr];
}

- (void)loadData
{
    [self serializeData];
}

#pragma mark - Private methods
- (void)serializeData
{
    [self.vc.headerView updateContent];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *cls = [self.vc.settingArr[indexPath.row] objectForKey:kMeVCClassName];
    FMBaseViewController *vc = nil;
    if ([cls isEqualToString:@"FMH5ViewController_wk"]) {
        vc = [[FMH5ViewController_wk alloc] initWithAddress:@"https://www.baidu.com"];
    } else {
        vc = [[NSClassFromString(cls) alloc] init];
    }
    vc.title = [self.vc.settingArr[indexPath.row] objectForKey:kMeVCTitle];
    [self.vc.fm_navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vc.settingArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:kMeCellReusedIdentifierStr forIndexPath:indexPath];
    [cell updateContentWithImg:[self.vc.settingArr[indexPath.row] objectForKey:kMeVCLogoStr] contentText:[self.vc.settingArr[indexPath.row] objectForKey:kMeVCTitle]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell tableView:tableView forRowAtIndexPath:indexPath animationStyle:UITableViewCellDisplayAnimationLeft];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //头部放大相关
    if ([change[@"new"] CGPointValue].y <= 0) {
        CGFloat multi = H_MeHeaderView/W_MeHeaderView;
        CGFloat tmp = 1 + (fabs([change[@"new"] CGPointValue].y)/(self.vc.mePulledTableView.ml_width*multi));
        self.vc.headerView.imgView.transform = CGAffineTransformMake(tmp, 0, 0, tmp, 0, ([change[@"new"] CGPointValue].y)/2.f);
    } else {
        self.vc.headerView.imgView.transform = CGAffineTransformIdentity;
    }
}

@end
