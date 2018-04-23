//
//  FMWaterFallFlowLayout.h
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMWaterFallFlowLayout;

@protocol FMWaterFallFlowLayoutDelegate<NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout;


@end

@interface FMWaterFallFlowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<FMWaterFallFlowLayoutDelegate> delegate;

@end
