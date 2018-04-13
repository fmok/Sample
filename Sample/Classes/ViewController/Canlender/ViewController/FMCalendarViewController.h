//
//  FMCalendarViewController.h
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "PulledTableView.h"

typedef NS_ENUM(NSInteger, CalendarAnimationType) {
    CalendarAnimationTypeShow = 100,
    CalendarAnimationTypeHidden
};

@class LTSCalendarManager;
@interface FMCalendarViewController : FMBaseViewController

@property (nonatomic, strong) LTSCalendarManager *manager;
@property (nonatomic, strong) PulledTableView *calendarTableView;

- (void)setTodayBtnHiddenState:(BOOL)hidden;

- (void)setSingleCalendarViewHiddenState:(BOOL)hidden;
- (void)setSingleCalendarViewAnimation:(CalendarAnimationType)type duration:(CGFloat)duration;

@end
