//
//  ViewController.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MainViewController.h"
#import "MainControl.h"

@interface MainViewController ()

@property (nonatomic, strong) MainControl *control;

@end

@implementation MainViewController

#pragma mark - life cycle
- (void)dealloc {
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
    self.zl_navigationBarHidden = YES;
    WS(weakSelf);
    [self.view addSubview:self.pulledTableView];
    [self.pulledTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    [self.control registerCell];
    [self.control loadData];
}

#pragma mark - Private methods


#pragma mark - getter & setter
- (MainControl *)control
{
    if (!_control) {
        _control = [[MainControl alloc] init];
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

- (MainHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MainHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*9.f/16.f)];
        _headerView.backgroundColor = [UIColor purpleColor];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
