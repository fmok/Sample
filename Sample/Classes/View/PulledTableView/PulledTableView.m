//
//  PulledTableView.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PulledTableView.h"
#import "MJRefresh.h"

@implementation PulledTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    _page = 1;
    _pageCount = 1;
    
    WS(weakSelf);
    // 下拉刷新
    
    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingBlock:^{
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

#pragma mark - public methods
- (void)finishRefreshTableWithType:(PulledTableViewType)type
{
    [self finishRefreshTableWithType:type isUpdateTime:YES];
}

- (void)finishRefreshTableWithType:(PulledTableViewType)type isUpdateTime:(BOOL)isUpdate
{
    // 完成刷新
    MJRefreshComponent *refreshView = nil;
    if (type == PulledTableViewTypeDown) {
        refreshView = self.mj_header;
    } else if (type == PulledTableViewTypeUp) {
        refreshView = self.mj_footer;
    }
    [refreshView endRefreshing];
    [self resetFooterData];
}

- (void)autoBeginRefreshing
{
    // 是否自动下拉 10分钟
    if (self.mj_header.lastUpdatedTime) {
        NSDate *nextUpdateDate = [[NSDate alloc] initWithTimeInterval:60*10 sinceDate:self.mj_header.lastUpdatedTime];
        if ([nextUpdateDate compare:[NSDate date]] == NSOrderedAscending) {
            [self beginRefreshing];
        }
    } else {
        // 之前的缓存时间没有，自动下拉
        [self beginRefreshing];
    }
}

- (void)autoBeginRefreshingWithFirstRequestNoRefresh
{
    // 是否自动下拉 10分钟
    if (self.mj_header.lastUpdatedTime) {
        NSDate *nextUpdateDate = [[NSDate alloc] initWithTimeInterval:60*10 sinceDate:self.mj_header.lastUpdatedTime];
        if ([nextUpdateDate compare:[NSDate date]] == NSOrderedAscending) {
            [self beginRefreshing];
        }
    } else {
        // 之前的缓存时间没有，无操作
    }
}

- (void)beginRefreshing
{
    if (self.mj_header.state == MJRefreshStateIdle) {
        
        [self.mj_header beginRefreshing];
    }
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

- (void)resetFooterData
{
    [self setFooterNoMoreData];
    [self resetFooterNoMoreData];
}

- (void)setAppearencePercentTriggerAutoRefresh:(CGFloat)space
{
    //self.mj_footer.appearencePercentTriggerAutoRefresh = space;
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

@end
