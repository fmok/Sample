//
//  FMCalendarControl.m
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCalendarControl.h"

@interface FMCalendarControl ()<UIScrollViewDelegate>
{
    NSMutableDictionary *eventsByDate;
    CGFloat _contentOffset_Y;
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
    _contentOffset_Y = [change[@"new"] CGPointValue].y;
    CGFloat change_Y_Old = [change[@"old"] CGPointValue].y;
    
//    NSIndexPath *indexPath = self.vc.manager.calenderScrollView.calendarView.currentSelectedIndexPath;
    CGFloat currentItem_Y = self.vc.manager.calenderScrollView.calendarView.singleWeekOffsetY;
    
    if (_contentOffset_Y >= 0) {
        if (_contentOffset_Y > change_Y_Old) {  // 上拉
            if (_contentOffset_Y >= currentItem_Y) {
                TTDPRINT(@"show");
                [self.vc setSingleCalendarViewHiddenState:NO];
            } else {

            }
        } else if (_contentOffset_Y < change_Y_Old) {  // 下拉
            if (_contentOffset_Y <= currentItem_Y) {
                TTDPRINT(@"hidden");
                [self.vc setSingleCalendarViewHiddenState:YES];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat H = [FMCalendarScrollView heightForCalendarScrollView];
    CGFloat h = [LTSCalendarAppearance share].weekDayHeight;
    CGPoint vel = [self.vc.calendarTableView.panGestureRecognizer velocityInView:self.vc.calendarTableView];
    CGFloat currentItem_Y = self.vc.manager.calenderScrollView.calendarView.singleWeekOffsetY;
    if (vel.y <= 0) {  // 上拉
        if (_contentOffset_Y >= currentItem_Y/2.f) {
            [self.vc setSingleCalendarViewAnimation:CalendarAnimationTypeShow duration:_contentOffset_Y];
        } else if (_contentOffset_Y < currentItem_Y/2.f) {
            [self.vc setSingleCalendarViewAnimation:CalendarAnimationTypeHidden duration:_contentOffset_Y];
        }
    } else if (vel.y > 0) {  // 下拉
//        if ((H-h)-_contentOffset_Y >= (H-(currentItem_Y+h))/2.f) {
//            [self.vc setSingleCalendarViewAnimation:CalendarAnimationTypeHidden];
//        } else {
//            [self.vc setSingleCalendarViewAnimation:CalendarAnimationTypeShow];
//        }
    }
}

#pragma mark - getter && setter
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.M.d";
    }
    
    return dateFormatter;
}

@end
