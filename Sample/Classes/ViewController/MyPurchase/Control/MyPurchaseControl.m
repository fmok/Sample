//
//  MyPurchaseControl.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseControl.h"

static NSString *const kMyPurchaseCellReusedIdentifier = @"kMyPurchaseCellReusedIdentifier";

@implementation MyPurchaseControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.pulledCollectionView registerClass:[MyPurchaseCell class] forCellWithReuseIdentifier:kMyPurchaseCellReusedIdentifier];
}

- (void)loadData
{
    
}

#pragma mark - Private methods

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTDPRINT(@"\n*** %@ - %@ ***\n", @(indexPath.section), @(indexPath.item));
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyPurchaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyPurchaseCellReusedIdentifier forIndexPath:indexPath];

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(W_MyPurchaseCell, H_MyPurchaseCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Gap_MyPurchaseCellEdges;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Gap_MyPurchaseCellEdges, Gap_MyPurchaseCellEdges, Gap_MyPurchaseCellEdges, Gap_MyPurchaseCellEdges);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return CGSizeMake(kScreenWidth-2*gap_left_right_myPurchase, 40.f);
//    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}


@end
