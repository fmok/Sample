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

#define Insert_left_right 15.f

@interface MainViewController : FMBaseViewController

@property (nonatomic, strong) PulledCollectionView *pulledCollectionView;
@property (nonatomic, strong) MainHeaderView *headerView;

@end
