//
//  FMCardsStackFlowLayout.m
//  Sample
//
//  Created by wjy on 2018/4/19.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCardsStackFlowLayout.h"

@implementation FMCardsStackFlowLayout

- (void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0.0f;
    self.minimumLineSpacing = 0.0f;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attrArr = [super layoutAttributesForElementsInRect:rect];
    return attrArr;
}

@end
