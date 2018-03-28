//
//  PulledCollectionView.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PulledCollectionView;

typedef NS_ENUM(NSUInteger, PulledCollectionViewType){
    PulledCollectionViewTypeUp,
    PulledCollectionViewTypeDown
};

@protocol PulledCollectionViewTypeDelegate <NSObject>

@optional

- (void)refreshWithPulledCollectionView:(PulledCollectionView *)collectionView;
- (void)loadMoreWithPulledCollectionView:(PulledCollectionView *)collectionView;

@end

@interface PulledCollectionView : UICollectionView

@property (nonatomic, weak  ) id<PulledCollectionViewTypeDelegate>pulledDelegate;
@property (nonatomic, assign) BOOL isHeader; //是否开启下拉刷新
@property (nonatomic, assign) BOOL isFooter; //是否开启上拉加载
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger pageCount;

/***/
- (void)refreshingDataSourceImmediately:(BOOL)immediately;
/** 完成刷新；isUpdateTime：是否记录时间 */
- (void)finishRefreshCollectionViewWithType:(PulledCollectionViewType)type;
- (void)finishRefreshCollectionViewWithType:(PulledCollectionViewType)type isUpdateTime:(BOOL)isUpdate;
/***/
- (void)setDataKey:(NSString *)key; // 设置下拉刷新的key
/***/
- (void)setFooterNoMoreData; //提示没有更多的数据
- (void)resetFooterNoMoreData;//重置没有更多的数据（消除没有更多数据的状态）

@end




