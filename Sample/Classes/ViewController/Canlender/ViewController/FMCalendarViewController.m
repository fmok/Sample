//
//  FMCalendarViewController.m
//  Sample
//
//  Created by wjy on 2018/4/10.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCalendarViewController.h"
#import "FMCalendarControl.h"
#import "UIImage+Resize.h"

static CGFloat const W_H_TodayBtn = 20.f;

@interface FMCalendarViewController ()<LTSCalendarEventSource>

@property (nonatomic, strong) FMCalendarControl *control;
@property (nonatomic, strong) UIButton *todayBtn;
@property (nonatomic, strong) UIView *singleCalendarView;

@end

@implementation FMCalendarViewController

- (void)dealloc
{
    [self.calendarTableView removeObserver:self.control forKeyPath:@"contentOffset" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBarBackgroundImage:[UIImage imageWithColor:SRGBCOLOR_HEX(0xc14945)]];
    [self setNav];
    self.zl_automaticallyAdjustsScrollViewInsets = NO;
    self.manager = [LTSCalendarManager new];
    self.manager.eventSource = self.control;
    
    WS(weakSelf);
    // week bar
    self.manager.weekDayView = [[FMCalendarWeekDayView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.manager.weekDayView];
    [self.manager.weekDayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(kNavBarHeight);
        } else {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(kNavBarHeight);
        }
        make.height.mas_equalTo(40.f);
    }];
    // calendar
    self.manager.calenderScrollView = [[FMCalendarScrollView alloc] initWithFrame:CGRectMake(0, 0, W_CalendarScrollView, [FMCalendarScrollView heightForCalendarScrollView])];
    self.manager.calenderScrollView.bgColor = [UIColor redColor];
    // tableView
    [self.view addSubview:self.calendarTableView];
    [self.calendarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.manager.weekDayView.mas_bottom);
    }];
    // singleCalendarView
    [self.view addSubview:self.singleCalendarView];
    [self.singleCalendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.manager.weekDayView.mas_bottom);
        make.height.mas_equalTo([LTSCalendarAppearance share].weekDayHeight);
    }];
    
    // add observer
    [self.calendarTableView addObserver:self.control forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
//    [self.control createRandomEventsForTest];
}

#pragma mark - Public methods
- (void)setTodayBtnHiddenState:(BOOL)hidden
{
    self.todayBtn.hidden = hidden;
}

- (void)setSingleCalendarViewHiddenState:(BOOL)hidden
{
    self.singleCalendarView.hidden = hidden;
}

- (void)setSingleCalendarViewAnimation:(BOOL)isShow duration:(CGFloat)duration
{
    if (isShow) {
        CGFloat realDuration = 0.8 - (duration/[FMCalendarScrollView heightForCalendarScrollView])*0.8;
        [UIView animateKeyframesWithDuration:realDuration delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            [self.calendarTableView setContentOffset:CGPointMake(0, [FMCalendarScrollView heightForCalendarScrollView]-[LTSCalendarAppearance share].weekDayHeight)];
        } completion:^(BOOL finished) {
        }];
    } else {
        CGFloat realDuration = (duration/[FMCalendarScrollView heightForCalendarScrollView])*0.8;
        [UIView animateKeyframesWithDuration:realDuration delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            [self.calendarTableView setContentOffset:CGPointMake(0, 0)];
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - Private methods
- (void)setNav
{
    UIBarButtonItem *todayItem = [[UIBarButtonItem alloc] initWithCustomView:self.todayBtn];
    self.zl_navigationItem.rightBarButtonItems = @[todayItem];
}


#pragma mark - getter & setter
- (FMCalendarControl *)control
{
    if (!_control) {
        _control = [[FMCalendarControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (UIButton *)todayBtn
{
    if (!_todayBtn) {
        _todayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, W_H_TodayBtn, W_H_TodayBtn)];
        [_todayBtn setTitle:@"今" forState:UIControlStateNormal];
        [_todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _todayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.f];
        _todayBtn.layer.cornerRadius = W_H_TodayBtn/2.f;
        _todayBtn.clipsToBounds = YES;
        [_todayBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_todayBtn.layer setBorderWidth:2.f];
        [_todayBtn addTarget:self.control action:@selector(cilckToday:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _todayBtn;
}

- (PulledTableView *)calendarTableView
{
    if (!_calendarTableView) {
        _calendarTableView = [[PulledTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _calendarTableView.delegate = self.control;
        _calendarTableView.dataSource = self.control;
        _calendarTableView.isHeader = NO;
        _calendarTableView.isFooter = NO;
        _calendarTableView.backgroundColor = [UIColor whiteColor];
        [_calendarTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCalendarScrollViewCellReusedIdentifier];
        _calendarTableView.estimatedSectionHeaderHeight = 0;
        _calendarTableView.estimatedSectionFooterHeight = 0;
        _calendarTableView.estimatedRowHeight = 0;
        _calendarTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _calendarTableView.showsVerticalScrollIndicator = NO;
        _calendarTableView.tableHeaderView = self.manager.calenderScrollView;
        _calendarTableView.bounces = NO;
    }
    return _calendarTableView;
}

- (UIView *)singleCalendarView
{
    if (!_singleCalendarView) {
        _singleCalendarView = [[UIView alloc] initWithFrame:CGRectZero];
        _singleCalendarView.backgroundColor = [UIColor whiteColor];
        _singleCalendarView.hidden = YES;
    }
    return _singleCalendarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
