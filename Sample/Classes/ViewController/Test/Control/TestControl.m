//
//  Control.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "TestControl.h"
#import "SampleListAPI.h"
#import "CardListModel.h"
#import "UIImageView+WebCache.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MainViewController.h"

static NSString *const kCellReusedIdentifier = @"kCellReusedIdentifier";

@interface TestControl()
{
    SampleListAPI *cacheAPI;
    SampleListAPI *refreshAPI;
    SampleListAPI *loadMoreAPI;
}

@end

@implementation TestControl

- (void)dealloc
{
    [cacheAPI stop];
    [refreshAPI stop];
    [loadMoreAPI stop];
}

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.pulledTableView registerClass:[InfoCell class] forCellReuseIdentifier:kCellReusedIdentifier];
}

- (void)loadData
{
    cacheAPI = [[SampleListAPI alloc] init];
    CardListModel *modelObj = [cacheAPI cacheJsonWithModelClass:[CardListModel class]];
    if (modelObj) {
        [self cleanDataSource];
        [self serializeData:modelObj];
    } else {
        [self.vc.pulledTableView refreshingDataSourceImmediately:YES];
    }
}

#pragma mark - Private methods
- (void)serializeData:(CardListModel *)modelObj
{
    [self.vc.cardInfoArr addObjectsFromArray:modelObj.list];
    [self.vc.pulledTableView reloadData];
}

- (void)cleanDataSource
{
    [self.vc.cardInfoArr removeAllObjects];
}

- (void)configureCell:(InfoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    CardInfoModel *model = self.vc.cardInfoArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = 100 + indexPath.row;
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell updateContent:model];
}

#pragma mark - PulledTableViewDelegate
- (void)refreshWithPulledTableView:(PulledTableView *)tableView
{
    WS(weakSelf);
    refreshAPI = [[SampleListAPI alloc] init];
    refreshAPI.ignoreCache = YES;
    [refreshAPI startWithJsonModelClass:[CardListModel class] success:^(FMRequest *request, id modelObj) {
        BOOL isRight = [request responseIsNormal];
        if (isRight) {
            [weakSelf cleanDataSource];
            [weakSelf serializeData:modelObj];
        } else {
            // 业务错误
            [weakSelf.vc showHUDTip:request.responseMessage];
        }
        [weakSelf.vc.pulledTableView finishRefreshTableWithType:PulledTableViewTypeDown isUpdateTime:isRight];
    } failure:^(FMRequest *request, id modelObj) {
        // 网络错误
        [weakSelf.vc showHUDTip:modelObj];
        [weakSelf.vc.pulledTableView finishRefreshTableWithType:PulledTableViewTypeDown isUpdateTime:NO];
    }];
}

- (void)loadMoreWithPulledTableView:(PulledTableView *)tableView
{
    WS(weakSelf);
    loadMoreAPI = [[SampleListAPI alloc] init];
    if (self.vc.pulledTableView.pageCount > self.vc.pulledTableView.page) {
        loadMoreAPI.page = self.vc.pulledTableView.page + 1;
    } else {
        [self.vc.pulledTableView setFooterNoMoreData];
        return;
    }
    [loadMoreAPI startWithJsonModelClass:[CardListModel class] success:^(FMRequest *request, id modelObj) {
        BOOL isRight = [request responseIsNormal];
        if (isRight) {
            [weakSelf serializeData:modelObj];
        } else {
            [weakSelf.vc showHUDTip:request.responseMessage];
        }
        [weakSelf.vc.pulledTableView finishRefreshTableWithType:PulledTableViewTypeUp isUpdateTime:isRight];
    } failure:^(FMRequest *request, id modelObj) {
        [weakSelf.vc showHUDTip:modelObj];
        [weakSelf.vc.pulledTableView finishRefreshTableWithType:PulledTableViewTypeUp isUpdateTime:NO];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kCellReusedIdentifier cacheByIndexPath:indexPath configuration:^(InfoCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewController *vc = [[MainViewController alloc] init];
//    vc.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
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
    return self.vc.cardInfoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReusedIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //头部放大相关
    if ([change[@"new"] CGPointValue].y <= 0) {
        CGFloat multi = H_MainHeaderView/W_MainHeaderView;
        CGFloat tmp = 1 + (fabs([change[@"new"] CGPointValue].y)/(self.vc.pulledTableView.ml_width*multi));
        self.vc.headerView.imgView.transform = CGAffineTransformMake(tmp, 0, 0, tmp, 0, ([change[@"new"] CGPointValue].y)/2.f);
    } else {
        self.vc.headerView.imgView.transform = CGAffineTransformIdentity;
    }
}

@end
