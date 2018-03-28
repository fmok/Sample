//
//  CardDetailControl.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardDetailViewController.h"

@interface CardDetailControl : NSObject<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    PulledCollectionViewTypeDelegate>

@property (nonatomic, weak) CardDetailViewController *vc;

- (void)registerCell;

@end
