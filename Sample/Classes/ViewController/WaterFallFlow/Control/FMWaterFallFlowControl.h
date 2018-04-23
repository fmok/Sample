//
//  FMWaterFallFlowControl.h
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMWaterFallFlowViewController.h"

@interface FMWaterFallFlowControl : NSObject<
    LMHWaterFallLayoutDelegate,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    PulledCollectionViewDelegate>

@property (nonatomic, weak) FMWaterFallFlowViewController *vc;

- (void)registerCell;
- (void)loadData;

@end
