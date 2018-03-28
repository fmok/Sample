//
//  Control.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestViewController.h"
#import "InfoCell.h"

@interface TestControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource,
    PulledTableViewDelegate>

@property (nonatomic, weak) TestViewController *vc;

- (void)registerCell;
- (void)loadData;

@end
