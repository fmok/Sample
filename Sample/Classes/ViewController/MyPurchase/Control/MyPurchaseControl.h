//
//  MyPurchaseControl.h
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPurchaseViewController.h"
#import "MyPurchaseCell.h"

@interface MyPurchaseControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource
    >

@property (nonatomic, strong) MyPurchaseViewController *vc;

- (void)registerCell;
- (void)loadData;

@end
