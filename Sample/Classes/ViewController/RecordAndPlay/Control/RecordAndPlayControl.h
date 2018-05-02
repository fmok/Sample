//
//  RecordAndPlayControl.h
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordAndPlayViewController.h"
#import "SingleRecordCell.h"

@interface RecordAndPlayControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, weak) RecordAndPlayViewController *vc;

- (void)registerCell;
- (void)testLoadData;

@end
