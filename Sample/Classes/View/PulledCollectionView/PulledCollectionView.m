//
//  PulledCollectionView.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PulledCollectionView.h"
#import "MJRefresh.h"

@implementation PulledCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        [self initializer];
    }
    return self;
}

- (void)dealloc
{
    TTDPRINT("");
}

- (void)initializer
{
    _page = 1;
    _pageCount = 1;
    
    WS(weakSelf);
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.pulledDelegate && [weakSelf.pulledDelegate respondsToSelector:@selector(refreshWithPulledTableView:)]) {
            [weakSelf.pulledDelegate refreshWithPulledTableView:weakSelf];
        }
    }];
    self.isHeader = YES;
    self.mj_header = header;
    
    // 上拉加载
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.pulledDelegate && [weakSelf.pulledDelegate respondsToSelector:@selector(loadMoreWithPulledTableView:)]) {
            if(weakSelf.page >= weakSelf.pageCount) {
                weakSelf.mj_footer.state = MJRefreshStateNoMoreData;
                return;
            };
            [weakSelf.pulledDelegate loadMoreWithPulledTableView:weakSelf];
        }
    }];
    self.isFooter = NO;
    MJRefreshAutoNormalFooter *mj_footer = (MJRefreshAutoNormalFooter *)self.mj_footer;
    mj_footer.triggerAutomaticallyRefreshPercent = -10.f;
}

#pragma mark - Public methods
- (void)refreshingDataSourceImmediately:(BOOL)immediately
{
    if (immediately) {
        [self beginRefreshing];
    } else {
        NSDate *updatedTime = self.mj_header.lastUpdatedTime;
        if (updatedTime) {
            NSDate *nextUpdateDate = [[NSDate alloc] initWithTimeInterval:60*10 sinceDate:updatedTime];
            if ([nextUpdateDate compare:[NSDate date]] == NSOrderedAscending) {
                [self.mj_header beginRefreshing];
            }
        }
    }
}

- (void)finishRefreshTableWithType:(PulledCollectionViewType)type
{
    [self finishRefreshTableWithType:type isUpdateTime:YES];
}

- (void)finishRefreshTableWithType:(PulledCollectionViewType)type isUpdateTime:(BOOL)isUpdate
{
    // 完成刷新
    MJRefreshComponent *refreshView = nil;
    if (type == PulledCollectionViewTypeDown) {
        refreshView = self.mj_header;
#warning todo
        //暂时未处理“记录刷新时间”
        //        [(MJRefreshNormalHeader *)refreshView endRefreshingWithUpdateTime:isUpdate];
    } else if (type == PulledCollectionViewTypeUp) {
        refreshView = self.mj_footer;
    }
    [refreshView endRefreshing];
    [self resetFooterData];
}

- (void)setDataKey:(NSString *)key
{
    self.mj_header.lastUpdatedTimeKey = [FMUtility refreshNameWithKey:key];
}

- (void)setFooterNoMoreData
{
    if (self.pageCount <= self.page) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)resetFooterNoMoreData
{
    if (self.pageCount > self.page) {
        [self.mj_footer resetNoMoreData];
    }
}

#pragma mark - Private methods
- (void)beginRefreshing
{
    if (self.mj_header.state == MJRefreshStateIdle) {
        [self.mj_header beginRefreshing];
    }
}

- (void)resetFooterData
{
    [self setFooterNoMoreData];
    [self resetFooterNoMoreData];
}

#pragma mark - getters and setters
- (void)setIsHeader:(BOOL)isHeader
{
    self.mj_header.hidden = !isHeader;
}

- (void)setIsFooter:(BOOL)isFooter
{
    self.mj_footer.hidden = !isFooter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
