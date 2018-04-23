//
//  FMWaterFallFlowControl.m
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMWaterFallFlowControl.h"
#import "FMWaterFallFlowCell.h"
#import "FMShopInfo.h"

static NSString *const kFMWaterFallFlowCellReusedIdentifier = @"FMWaterFallFlowCell";

@implementation FMWaterFallFlowControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.collectionView registerClass:[FMWaterFallFlowCell class] forCellWithReuseIdentifier:kFMWaterFallFlowCellReusedIdentifier];
}

- (void)loadData
{
    
}

#pragma mark - Private methods

#pragma mark - PulledCollectionViewDelegate
- (void)refreshWithPulledCollectionView:(PulledCollectionView *)collectionView
{
    
}

- (void)loadMoreWithPulledCollectionView:(PulledCollectionView *)collectionView
{
    
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
//    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    
    return self.vc.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FMWaterFallFlowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFMWaterFallFlowCellReusedIdentifier forIndexPath:indexPath];
    FMShopInfo *model = self.vc.shops[indexPath.item];
    [cell updateContentWithImgUrl:model.img price:model.price];
    return cell;
}

#pragma mark - LMHWaterFallLayoutDelegate
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth
{
    FMShopInfo * shop = self.vc.shops[indexPath];
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout
{
    return 20;
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout
{
    return 2;
}


@end
