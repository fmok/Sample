//
//  CardDetailControl.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CardDetailControl.h"
#import "CollectionViewCell.h"
#import "CollectionSectionHeaderView.h"

static NSString *const kCollectionViewCellReusedIdentifierStr = @"kCollectionViewCellReusedIdentifierStr";
static NSString *const kCollectionSectionHeaderViewReusedIdentifierStr = @"kCollectionSectionHeaderViewReusedIdentifierStr";

@implementation CardDetailControl

- (void)dealloc
{
}

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.pulledCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellReusedIdentifierStr];
    [self.vc.pulledCollectionView registerClass:[CollectionSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionSectionHeaderViewReusedIdentifierStr];
}

#pragma mark - Private methods

#pragma mark - PulledCollectionViewTypeDelegate
- (void)refreshWithPulledCollectionView:(PulledCollectionView *)collectionView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [collectionView finishRefreshCollectionViewWithType:PulledCollectionViewTypeDown];
    });
}

- (void)loadMoreWithPulledCollectionView:(PulledCollectionView *)collectionView
{
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTDPRINT(@"\n*** %@ - %@ ***\n", @(indexPath.section), @(indexPath.item));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CollectionSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionSectionHeaderViewReusedIdentifierStr forIndexPath:indexPath];
        
        return header;
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellReusedIdentifierStr forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(W_CollectionViewCell, H_CollectionViewCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Gap_CollectionViewEdges;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Gap_CollectionViewEdges, Gap_CollectionViewEdges, Gap_CollectionViewEdges, Gap_CollectionViewEdges);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenWidth-2*Insert_left_right, 40.f);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}


@end





