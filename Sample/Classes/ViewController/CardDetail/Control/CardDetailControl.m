//
//  CardDetailControl.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CardDetailControl.h"
#import "CollectionViewCell.h"

static NSString *const kCollectionViewCellReusedIdentifierStr = @"kCollectionViewCellReusedIdentifierStr";

@implementation CardDetailControl

- (void)dealloc
{
}

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.pulledCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellReusedIdentifierStr];
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
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
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
    return CGSizeMake(W_H_MylistenInAlbumCell_Image, H_MylistenInAlbumCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Gap_MylistenInAlnumEdges;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Gap_MylistenInAlnumEdges, Gap_MylistenInAlnumEdges, Gap_MylistenInAlnumEdges, Gap_MylistenInAlnumEdges);
}


@end





