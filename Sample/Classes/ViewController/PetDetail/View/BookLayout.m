//
//  BookLayout.m
//  Mood
//
//  Created by hehe on 15/9/19.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "BookLayout.h"

@implementation BookLayout


//定义cell的尺寸
static CGFloat pageWidth = 180;
static CGFloat pageHeight = 280;
static CGFloat numberOfPages = 0; //定义总的cell个数


- (void)prepareLayout {
    [super prepareLayout];
    //滚动结束时,翻动快些
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    numberOfPages = [self.collectionView numberOfItemsInSection:0];
    self.collectionView.pagingEnabled = YES;//滚动视图整页翻动
}


//布局实时更新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


//内容滚动区域设置
- (CGSize)collectionViewContentSize {
    //每个视图上显示两页
    CGFloat width = numberOfPages / 2 - 1;
    return CGSizeMake(width * self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
}



//每个cell的布局设置
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取cell的布局
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    //设置frame
    CGRect frame;
    frame.origin.x = self.collectionView.bounds.size.width / 2 - pageWidth / 2 + self.collectionView.contentOffset.x;
    frame.origin.y = (self.collectionViewContentSize.height - pageHeight) / 2;
    frame.size.width = pageWidth;
    frame.size.height = pageHeight;
    layoutAttributes.frame = frame;
    
    //设置ratio
    CGFloat page = (indexPath.item - indexPath.item % 2) * 0.5; //结果 0,0,1,1,2,2 ...
    CGFloat ratio = - 0.5 + page - (self.collectionView.contentOffset.x / self.collectionView.bounds.size.width); //通过偏移量,获取比重
    //限制比重
    if (ratio > 0.5) {
        ratio = 0.5 + 0.1 * (ratio - 0.5);
    } else if (ratio < -0.5) {
        ratio = - 0.5 + 0.1 * (ratio + 0.5);
    }
    
    
    //
    if ((ratio > 0 && indexPath.item % 2 == 1) || (ratio < 0 && indexPath.item % 2 == 0)) {
        if (indexPath.row != 1) {
            return nil;
        }
    }
    
    
    //计算旋转角度angle,设定3D旋转
    CGFloat newRatio = MIN(MAX(ratio, -1), 1);
    //计算m34
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / - 2000;
    
    CGFloat angle = 0.0f;
    if (indexPath.item % 2 == 0) {
        //中心线在左边
        angle = (1 - newRatio) * (-M_PI_2);
    } else if (indexPath.item % 2 == 1) {
        angle = (1 + newRatio) * (M_PI_2);
    }
    angle += (indexPath.row % 2) / 1000;
    
    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    
    layoutAttributes.transform3D = transform;
    if (indexPath.row == 0) {
        layoutAttributes.zIndex = NSIntegerMax;
    }
    return layoutAttributes;
}


//所有cell布局数组
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < numberOfPages; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:index];
        if (attributes != nil) {
            [array addObject:attributes];
        }
    }
    return array;
}
@end
