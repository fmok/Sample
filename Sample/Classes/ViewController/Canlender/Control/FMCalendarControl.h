//
//  FMCalendarControl.h
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMCalendarViewController.h"
#import "LTSCalendarManager.h"

static NSString *const kCalendarScrollViewCellReusedIdentifier = @"kCalendarScrollViewCellReusedIdentifier";

@interface FMCalendarControl : NSObject <
    LTSCalendarEventSource,
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, weak) FMCalendarViewController *vc;

- (void)createRandomEventsForTest;
- (void)cilckToday:(UIButton *)sender;

@end
