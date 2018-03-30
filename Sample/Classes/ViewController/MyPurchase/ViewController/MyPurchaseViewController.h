//
//  MyPurchaseViewController.h
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "PulledCollectionView.h"

static CGFloat const gap_left_right_myPurchase = 14.5f;

@interface MyPurchaseViewController : FMBaseViewController

@property (nonatomic, strong) PulledCollectionView *pulledCollectionView;

@end
