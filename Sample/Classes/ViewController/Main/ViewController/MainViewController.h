//
//  CardDetailViewController.h
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "PulledCollectionView.h"
#import "MainHeaderView.h"
#import "CollectionSectionHeaderView.h"

static CGFloat const gap_left_right_main = 14.5f;

@interface MainViewController : FMBaseViewController

@property (nonatomic, strong) PulledCollectionView *pulledCollectionView;
@property (nonatomic, strong) MainHeaderView *headerView;

@end
