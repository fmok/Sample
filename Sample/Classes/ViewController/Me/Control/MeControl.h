//
//  MeControl.h
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeViewController.h"

@interface MeControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, weak) MeViewController *vc;

- (void)registerCell;

@end
