//
//  FMCardsStackScrollView.h
//  Sample
//
//  Created by wjy on 2018/4/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardStackSingleCell.h"

@protocol FMCardsStackScrollViewDelegate <NSObject>

//@optional
- (void)cardScrollToIndex:(NSInteger)idx;

@end

@interface FMCardsStackScrollView : UIScrollView

@property (nonatomic, weak) id<FMCardsStackScrollViewDelegate>cardStackScrollDelegate;

- (void)updateContent;
- (void)setInitailIndexCard:(NSInteger)idx;

@end
