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
#import "FMWaterFallFlowShopModel.h"

static NSString *const kFMWaterFallFlowCellReusedIdentifier = @"FMWaterFallFlowCell";

@implementation FMWaterFallFlowControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.collectionView registerClass:[FMWaterFallFlowCell class] forCellWithReuseIdentifier:kFMWaterFallFlowCellReusedIdentifier];
}

- (void)loadData
{
    [self testCatchData:NO];
}

#pragma mark - Private methods
- (void)testCatchData:(BOOL)isLoadMore
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!isLoadMore) {
            [self.vc.shops removeAllObjects];
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shop" ofType:@"plist"];
        NSArray *shops = [[NSArray alloc] initWithContentsOfFile:filePath];
        
        NSError *error;
        for (NSDictionary *dic in shops) {
            FMWaterFallFlowShopModel *model = [[FMWaterFallFlowShopModel alloc] initWithDictionary:dic error:&error];
            if (!error) {
                [self.vc.shops addObject:model];
            } else {
                TTDPRINT(@"\n*** %@ ***\n", error);
            }
        }
        [self.vc.collectionView reloadData];
    });
}

#pragma mark - PulledCollectionViewDelegate
- (void)refreshWithPulledCollectionView:(PulledCollectionView *)collectionView
{
    [self testCatchData:NO];
    [self.vc.collectionView finishRefreshCollectionViewWithType:PulledCollectionViewTypeDown isUpdateTime:YES];
}

- (void)loadMoreWithPulledCollectionView:(PulledCollectionView *)collectionView
{
    [self testCatchData:YES];
    [self.vc.collectionView finishRefreshCollectionViewWithType:PulledCollectionViewTypeUp isUpdateTime:NO];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTDPRINT(@"");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{   
    return self.vc.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FMWaterFallFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFMWaterFallFlowCellReusedIdentifier forIndexPath:indexPath];
    FMWaterFallFlowShopModel *model = self.vc.shops[indexPath.item];
    [cell updateContentWithImgUrl:model.img price:model.price];
    return cell;
}

#pragma mark - LMHWaterFallLayoutDelegate
- (CGFloat)waterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth
{
    FMWaterFallFlowShopModel * shop = self.vc.shops[indexPath];
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout
{
    return 10;
}

- (NSUInteger)columnCountInWaterFallLayout:(FMWaterFallFlowLayout *)waterFallLayout
{
    return 2;
}


@end
