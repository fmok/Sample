//
//  FMCalendarScrollView.m
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCalendarScrollView.h"

@interface FMCalendarScrollView() <
    UIScrollViewDelegate>

@end

@implementation FMCalendarScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [LTSCalendarAppearance share].scrollBgcolor;
        [self addSubview:self.calendarView];
    }
    return self;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
//    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
//    if ( appearce.isShowSingleWeek) {
//        if (self.contentOffset.y != tableCountDistance) {
//            return  nil;
//        }
//    }
//    if ( !appearce.isShowSingleWeek) {
//        if (self.contentOffset.y != 0 ) {
//            return  nil;
//        }
//    }
//    return  [super hitTest:point withEvent:event];
//}

#pragma mark - Private methods



#pragma mark - Public methods
- (void)scrollToSingleWeek
{
    
    LTSCalendarAppearance *appearce = [LTSCalendarAppearance share];
    // 表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    [self setContentOffset:CGPointMake(0, tableCountDistance) animated:YES];
}

- (void)scrollToAllWeek
{
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

+ (CGFloat)heightForCalendarScrollView
{
    return [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay;
}

#pragma mark - getter & setter
- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

- (LTSCalendarContentView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [[LTSCalendarContentView alloc] initWithFrame:CGRectMake(0, 0, W_CalendarScrollView, [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay)];
        _calendarView.currentDate = [NSDate date];
    }
    return _calendarView;
}

@end
