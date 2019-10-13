//
//  LTSCalendarManager.h
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMCalendarScrollView.h"
#import "LTSCalendarEventSource.h"
#import "FMCalendarWeekDayView.h"

@interface LTSCalendarManager : NSObject
@property (nonatomic,strong) FMCalendarScrollView *calenderScrollView;

@property (nonatomic,strong) FMCalendarWeekDayView *weekDayView;

@property (weak, nonatomic) id<LTSCalendarEventSource> eventSource;

@property (nonatomic,strong,readonly) NSDate *currentSelectedDate;


///回到固定某天
- (void)goToDate:(NSDate *)date;

/// 重新加载外观
- (void)reloadAppearanceAndData;

///  前一页。上个月
- (void)loadPreviousPage;
///   下一页 下一个月

- (void)loadNextPage;
- (void)showSingleWeek;
- (void)showAllWeek;
@end
