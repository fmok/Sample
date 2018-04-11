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

@end

@implementation FMCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBarBackgroundImage:[UIImage imageWithColor:SRGBCOLOR_HEX(0xc14945)]];
    [self setNav];
    self.zl_automaticallyAdjustsScrollViewInsets = NO;
    self.manager = [LTSCalendarManager new];
    self.manager.eventSource = self.control;
    
    WS(weakSelf);
    //
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
    //
    self.manager.calenderScrollView = [[FMCalendarScrollView alloc] initWithFrame:CGRectZero];
    self.manager.calenderScrollView.bgColor = [UIColor redColor];
    [self.view addSubview:self.manager.calenderScrollView];
    [self.manager.calenderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.manager.weekDayView.mas_bottom);
        make.bottom.equalTo(weakSelf.view);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(W_CalendarScrollView);
    }];
    //
//    [self.control createRandomEventsForTest];
// Do any additional setup after loading the view.

}

#pragma mark - Public methods
- (void)setTodayBtnHiddenState:(BOOL)hidden
{
    self.todayBtn.hidden = hidden;
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
