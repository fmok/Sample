//
//  PulledTableView.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PulledTableView;

typedef NS_ENUM(NSUInteger, PulledTableViewType){
    PulledTableViewTypeUp,
    PulledTableViewTypeDown
};

@protocol PulledTableViewDelegate <NSObject>

@optional

- (void)refreshWithPulledTableView:(PulledTableView *)tableView;
- (void)loadMoreWithPulledTableView:(PulledTableView *)tableView;

@end

@interface PulledTableView : UITableView

@property (nonatomic, weak  ) id<PulledTableViewDelegate>pulledDelegate;
@property (nonatomic, assign) BOOL isHeader; //是否开启下拉刷新
@property (nonatomic, assign) BOOL isFooter; //是否开启下拉加载
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, assign) CGFloat appearencePercentTriggerAutoRefresh;

// 完成刷新；isUpdateTime：是否记录时间
- (void)finishRefreshTableWithType:(PulledTableViewType)type;
- (void)finishRefreshTableWithType:(PulledTableViewType)type isUpdateTime:(BOOL)isUpdate;
- (void)autoBeginRefreshing; // 检测是否需要自动下拉
- (void)autoBeginRefreshingWithFirstRequestNoRefresh;
- (void)beginRefreshing; // 强制刷新
- (void)setDataKey:(NSString *)key; // 设置下拉刷新的key
- (void)setFooterNoMoreData; //提示没有更多的数据
- (void)resetFooterNoMoreData;//重置没有更多的数据（消除没有更多数据的状态）

@end





