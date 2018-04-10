//
//  LTSCalendarWeekDayView.m
//  scrollTest
//
//  Created by leetangsong_macbk on 16/5/27.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "FMCalendarWeekDayView.h"
#import "LTSCalendarAppearance.h"

@interface FMCalendarWeekDayView ()

@property (nonatomic, strong) NSMutableArray *daysViewsForWeekArr;

@end

@implementation FMCalendarWeekDayView

static NSArray *cacheDaysOfWeeks;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self.daysViewsForWeekArr removeAllObjects];
        for (NSInteger i = 0; i < [self daysOfWeek].count; i++) {
            @autoreleasepool {
                NSString *day = [[self daysOfWeek] objectAtIndex:i];
                UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
                view.font = [LTSCalendarAppearance share].weekDayTextFont;
                view.textColor = [LTSCalendarAppearance share].weekDayTextColor;
                view.textAlignment = NSTextAlignmentCenter;
                view.text = day;
                [self addSubview:view];
                [self.daysViewsForWeekArr addObject:view];
            }
        }
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    CGFloat W_Day = kScreenWidth / (CGFloat)self.daysViewsForWeekArr.count;
    UILabel *view1 = [self.daysViewsForWeekArr firstObject];
    [view1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(weakSelf);
        make.width.mas_equalTo(W_Day);
    }];
    for (NSInteger i = 1; i < self.daysViewsForWeekArr.count; i++) {
        @autoreleasepool {
            UILabel *view = [self.daysViewsForWeekArr objectAtIndex:i];
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view1.mas_right);
                make.top.and.bottom.equalTo(weakSelf);
                make.width.mas_equalTo(W_Day);
            }];
            view1 = view;
        }
    }
    
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)reloadAppearance
{
    for (NSInteger i = 0; i < [self daysOfWeek].count; i++) {
        @autoreleasepool {
            NSString *day = [[self daysOfWeek] objectAtIndex:i];
            UILabel *view = [self.daysViewsForWeekArr objectAtIndex:i];
            view.font = [LTSCalendarAppearance share].weekDayTextFont;
            view.textColor = [LTSCalendarAppearance share].weekDayTextColor;
            view.textAlignment = NSTextAlignmentCenter;
            view.text = day;
        }
    }
    self.backgroundColor = [LTSCalendarAppearance share].weekDayBgColor;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter
- (NSArray *)daysOfWeek
{
    //
    if(cacheDaysOfWeeks){
        return cacheDaysOfWeeks;
    }
    
    //
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSMutableArray *days = nil;
    
    switch([LTSCalendarAppearance share].weekDayFormat) {
        case LTSCalendarWeekDayFormatSingle:
            days = [[dateFormatter veryShortStandaloneWeekdaySymbols] mutableCopy];
            break;
        case LTSCalendarWeekDayFormatShort:
            days = [[dateFormatter shortStandaloneWeekdaySymbols] mutableCopy];
            break;
        case LTSCalendarWeekDayFormatFull:
            days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];
            break;
    }
    
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
    }
    
    // Redorder days for be conform to calendar
    {
        /**
         days 默认顺序：     日   一   二   三   四   五   六
         firstWeekday：     1    2    3   4    5    6   7
         根据 calendar.firstWeekday 设置，调整 days 的顺序
         */
        NSCalendar *calendar = [LTSCalendarAppearance share].calendar;
        NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
        
        for(int i = 0; i < firstWeekday; ++i){
            id day = [days firstObject];
            [days removeObjectAtIndex:0];
            [days addObject:day];
        }
    }
    
    cacheDaysOfWeeks = days;
    return cacheDaysOfWeeks;
}

- (NSMutableArray *)daysViewsForWeekArr
{
    if (!_daysViewsForWeekArr) {
        _daysViewsForWeekArr = [[NSMutableArray alloc] init];
    }
    return _daysViewsForWeekArr;
}

#pragma mark - Class methods
+ (void)beforeReloadAppearance
{
    cacheDaysOfWeeks = nil;
}

@end
