//
//  FMCalendarScrollView.h
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LTSCalendarContentView.h"

@interface FMCalendarScrollView : UIScrollView

@property (nonatomic,strong) LTSCalendarContentView *calendarView;

@property (nonatomic,strong) UIColor *bgColor;

- (void)scrollToSingleWeek;
- (void)scrollToAllWeek;

@end
