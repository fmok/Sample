//
//  FMWaterFallFlowViewController.h
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "FMWaterFallFlowLayout.h"
#import "PulledCollectionView.h"

@interface FMWaterFallFlowViewController : FMBaseViewController

@property (nonatomic, strong) PulledCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;

@end
