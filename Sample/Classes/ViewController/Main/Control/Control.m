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
#import "UIImageView+WebCache.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString *const kCellReusedIdentifier = @"kCellReusedIdentifier";

@interface Control()
{
    SampleListAPI *cacheAPI;
    SampleListAPI *refreshAPI;
    SampleListAPI *loadMoreAPI;
}

@end

@implementation Control

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
        [self.vc.pulledTableView beginRefreshing];
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
            [HUD showTipWithText:request.responseJMMessage];
        }
        [weakSelf.vc.pulledTableView finishRefreshTableWithType:PulledTableViewTypeDown isUpdateTime:isRight];
    } failure:^(FMRequest *request, id modelObj) {
        // 网络错误
        [HUD showTipWithText:modelObj];
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
            [HUD showTipWithText:request.responseJMMessage];
        }
        [weakSelf.vc.pulledTableView finishRefreshTableWithType:PulledTableViewTypeUp isUpdateTime:isRight];
    } failure:^(FMRequest *request, id modelObj) {
        [HUD showTipWithText:modelObj];
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
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.vc.navigationController pushViewController:vc animated:YES];
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

@end
