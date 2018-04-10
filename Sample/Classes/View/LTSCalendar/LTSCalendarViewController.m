//
//  LTSCalendarViewController.m
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/12.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import "LTSCalendarViewController.h"
#import "LTSCalendarManager.h"

@interface LTSCalendarViewController ()<LTSCalendarEventSource>
{
    NSMutableDictionary *eventsByDate;
}

@property (nonatomic, strong)LTSCalendarManager *manager;

@end

@implementation LTSCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBarBackgroundImage:[UIImage imageNamed:@"nav.png"]];
    [self setNav];
    self.manager = [LTSCalendarManager new];
    self.manager.eventSource = self;
    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
//    WS(weakSelf);
//    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.manager.weekDayView];
//    [self.manager.weekDayView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(weakSelf.view);
//        if (@available(iOS 11.0, *)) {
//            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(kNavBarHeight);
//        } else {
//            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(kNavBarHeight);
//        }
//        make.height.mas_equalTo(30.f);
//    }];
    
    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manager.weekDayView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.manager.weekDayView.frame))];
//    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.manager.calenderScrollView];
//    [self.manager.calenderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.and.bottom.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.manager.weekDayView.mas_bottom);
//    }];
    [self createRandomEvents];
//    self.automaticallyAdjustsScrollViewInsets = false;
    // Do any additional setup after loading the view.
    
}

#pragma mark - Private methods
- (void)setNav
{
    
//    self.zl_navigationItem.rightBarButtonItems
}
- (void)createRandomEvents
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
    [self.manager reloadAppearanceAndData];
}

#pragma mark - LTSCalendarEventSource
- (void)calendarDidLoadPageCurrentDate:(NSDate *)date {
    
}

- (void)calendarDidSelectedDate:(NSDate *)date {
    NSString *key = [[self dateFormatter] stringFromDate:date];
    [self changeNavBarTitle:key];
    NSArray *events = eventsByDate[key];
    TTDPRINT(@"%@",date);
    if (events.count>0) {
        //该日期有事件    tableView 加载数据
    }
}

- (BOOL)calendarHaveEventWithDate:(NSDate *)date {
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

#pragma mark - getter
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
