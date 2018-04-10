//
//  FMCalendarScrollView.m
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCalendarScrollView.h"

@interface FMCalendarScrollView() <UIScrollViewDelegate>

@end

@implementation FMCalendarScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//}

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
- (void)initUI
{
    self.delegate = self;
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [LTSCalendarAppearance share].scrollBgcolor;
    LTSCalendarContentView *calendarView = [[LTSCalendarContentView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay)];
    calendarView.currentDate = [NSDate date];
    [self addSubview:calendarView];
    self.calendarView = calendarView;
    [LTSCalendarAppearance share].isShowSingleWeek ? [self scrollToSingleWeek]:[self scrollToAllWeek];
}

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

#pragma mark - getter & setter
- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

@end
