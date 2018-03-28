//
//  CardDetailControl.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"

@interface MainControl : NSObject<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    PulledCollectionViewTypeDelegate>

@property (nonatomic, weak) MainViewController *vc;

- (void)registerCell;
- (void)loadData;

@end
