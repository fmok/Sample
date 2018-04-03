//
//  CollectionSectionHeaderView.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SortType) {
    SortTypeNULL,
    SortTypeByValue,  // 按价值排序
    SortTypeBtRest  // 按剩余排序
};

@protocol CollectionSectionHeaderViewDelegate <NSObject>

- (void)sortByType:(SortType)type;

@end

@interface CollectionSectionHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<CollectionSectionHeaderViewDelegate>delegate;

@end
