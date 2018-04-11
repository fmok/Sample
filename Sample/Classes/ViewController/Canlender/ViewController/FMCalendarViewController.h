//
//  FMCalendarViewController.h
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"

@class LTSCalendarManager;
@interface FMCalendarViewController : FMBaseViewController

@property (nonatomic, strong) LTSCalendarManager *manager;

- (void)setTodayBtnHiddenState:(BOOL)hidden;

@end
