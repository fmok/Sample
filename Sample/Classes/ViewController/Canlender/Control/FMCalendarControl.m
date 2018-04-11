//
//  FMCalendarControl.m
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCalendarControl.h"

@interface FMCalendarControl ()
{
    NSMutableDictionary *eventsByDate;
}

@end

@implementation FMCalendarControl


#pragma mark - Public methods
- (void)createRandomEventsForTest
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
    }
    [self.vc.manager reloadAppearanceAndData];
}

- (void)cilckToday:(UIButton *)sender
{
    [self.vc.manager goToDate:[NSDate date]];
}

#pragma mark - LTSCalendarEventSource
- (void)calendarDidLoadPageCurrentDate:(NSDate *)date
{
    
}

- (void)calendarDidSelectedDate:(NSDate *)date
{
    TTDPRINT(@"%@",date);
    // 判断隐藏 今 按钮
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-d"];
    NSString *selectedDateStr = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    NSString *currentDateStr = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate date]]];
    [self.vc setTodayBtnHiddenState:[selectedDateStr isEqualToString:currentDateStr]];
    // 记录当前显示的日期
    [LTSCalendarAppearance share].currentShowDate = date;
    // 改变VC上的title
    NSString *key = [[self dateFormatter] stringFromDate:date];
    [self.vc changeNavBarTitle:key];
    // 获取当前日期事件
    NSArray *events = eventsByDate[key];
    if (events.count>0) {
        //该日期有事件    tableView 加载数据
    }
}

- (BOOL)calendarHaveEventWithDate:(NSDate *)date
{
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

#pragma mark - getter && setter
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    
    return dateFormatter;
}

@end
