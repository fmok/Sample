//
//  ViewController.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "TestViewController.h"
#import "TestControl.h"

@interface TestViewController ()

@property (nonatomic, strong) TestControl *control;

@end

@implementation TestViewController

#pragma mark - life cycle
- (void)dealloc {
    [self.pulledTableView removeObserver:self.control forKeyPath:@"contentOffset"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pulledTableView refreshingDataSourceImmediately:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fm_navigationBarHidden = YES;
    WS(weakSelf);
    [self.view addSubview:self.pulledTableView];
    [self.pulledTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    [self.control registerCell];
    [self.control loadData];
    
    [self.pulledTableView addObserver:self.control forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - Private methods


#pragma mark - getter & setter
- (TestControl *)control
{
    if (!_control) {
        _control = [[TestControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (PulledTableView *)pulledTableView
{
    if (!_pulledTableView) {
        _pulledTableView = [[PulledTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _pulledTableView.backgroundColor = [UIColor whiteColor];
        _pulledTableView.isHeader = YES;
        _pulledTableView.isFooter = YES;
        _pulledTableView.showsVerticalScrollIndicator = YES;
        _pulledTableView.estimatedRowHeight = 0;
        _pulledTableView.delegate = self.control;
        _pulledTableView.dataSource = self.control;
        _pulledTableView.pulledDelegate = self.control;
        _pulledTableView.tableHeaderView = self.headerView;
        _pulledTableView.estimatedRowHeight = 0;
        _pulledTableView.estimatedSectionHeaderHeight = 0;
        _pulledTableView.estimatedSectionFooterHeight = 0;
#ifdef __IPHONE_11_0
        if ([_pulledTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                _pulledTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
#endif
    }
    return _pulledTableView;
}

- (NSMutableArray *)cardInfoArr
{
    if (!_cardInfoArr) {
        _cardInfoArr = [[NSMutableArray alloc] init];
    }
    return _cardInfoArr;
}

- (TestHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[TestHeaderView alloc] initWithFrame:CGRectMake(0, 0, W_MainHeaderView, H_MainHeaderView)];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
