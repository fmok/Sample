//
//  Control.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface Control : NSObject<
    UITableViewDelegate,
    UITableViewDataSource,
    PulledTableViewDelegate>

@property (nonatomic, weak) ViewController *vc;

- (void)registerCell;
- (void)testRequest;

@end
