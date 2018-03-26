//
//  Control.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "InfoCell.h"

@interface MainControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource,
    PulledTableViewDelegate>

@property (nonatomic, weak) MainViewController *vc;

- (void)registerCell;
- (void)loadData;

@end
