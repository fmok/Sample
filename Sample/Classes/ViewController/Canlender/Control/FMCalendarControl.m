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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarScrollViewCellReusedIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];
    return cell;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat change_Y = [change[@"new"] CGPointValue].y;
    TTDPRINT(@"\n*** %@ ***", @(change_Y));
    if (change_Y <= 0) {
        
    } else {
        if (change_Y >= [FMCalendarScrollView heightForCalendarScrollView]) {
//            CGFloat distance = change_Y-[FMCalendarScrollView heightForCalendarScrollView];
//            CGRect frame = self.vc.manager.weekDayView.frame;
//            frame.origin.y -= distance;
//            self.vc.manager.weekDayView.frame = frame;
//            [self.vc.manager.weekDayView mas_updateConstraints:^(MASConstraintMaker *make) {
//                if (@available(iOS 11.0, *)) {
//                    make.top.equalTo(weakSelf.vc.view.mas_safeAreaLayoutGuideTop).offset(kNavBarHeight-distance);
//                } else {
//                    make.top.equalTo(weakSelf.vc.mas_topLayoutGuide).offset(kNavBarHeight-distance);
//                }
//            }];
        }
    }
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
