//
//  FMCalendarSingleView.m
//  Sample
//
//  Created by wjy on 2018/4/20.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCalendarSingleView.h"
#import "LTSCalendarContentView.h"

@interface FMCalendarSingleView ()

@property (nonatomic, strong) LTSCalendarContentView *singleCalendarView;

@end

@implementation FMCalendarSingleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.singleCalendarView];
    }
    return self;
}

#pragma mark - getter & setter
- (LTSCalendarContentView *)singleCalendarView
{
    if (!_singleCalendarView) {
        _singleCalendarView = [[LTSCalendarContentView alloc] initWithFrame:CGRectMake(0, 0, W_CalendarScrollView, [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay)];
        _singleCalendarView.isShowBottomLine = NO;
    }
    return _singleCalendarView;
}

@end
