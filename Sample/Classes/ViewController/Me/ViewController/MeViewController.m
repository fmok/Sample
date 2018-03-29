//
//  MeViewController.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeViewController.h"
#import "MeControl.h"
#import "UIImage+Resize.h"

@interface MeViewController ()

@property (nonatomic, strong) MeControl *control;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(weakSelf);
    [self.view addSubview:self.mePulledTableView];
    [self.mePulledTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(iOS 11.0, *)) {
//            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(44.f);
//        } else {
//            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(44.f);
//        }
//        make.left.and.right.and.bottom.equalTo(weakSelf.view);
        make.edges.equalTo(weakSelf.view);
    }];
    [self.control registerCell];
    [self customNav];
    [self.mePulledTableView addObserver:self.control forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - Private methods
- (void)customNav
{
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.title = self.title;
    [self.zl_navigationBar pushNavigationItem:item animated:NO];
    [self.view addSubview:self.zl_navigationBar];
    [self constraintNavigationBar:self.zl_navigationBar];
}

#pragma mark - getter & setter
- (MeControl *)control
{
    if (!_control) {
        _control = [[MeControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (PulledTableView *)mePulledTableView
{
    if (!_mePulledTableView) {
        _mePulledTableView = [[PulledTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mePulledTableView.backgroundColor = [UIColor clearColor];
        _mePulledTableView.delegate = self.control;
        _mePulledTableView.dataSource = self.control;
        _mePulledTableView.estimatedRowHeight = 0;
        _mePulledTableView.estimatedSectionHeaderHeight = 0;
        _mePulledTableView.estimatedSectionFooterHeight = 0;
        _mePulledTableView.isHeader = NO;
        _mePulledTableView.isFooter = NO;
        _mePulledTableView.tableHeaderView = self.headerView;
#ifdef __IPHONE_11_0
        if ([_mePulledTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                _mePulledTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
#endif
    }
    return _mePulledTableView;
}

- (MeHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, W_MeHeaderView, H_MeHeaderView)];
    }
    return _headerView;
}

- (NSArray *)ImgArr
{
    if (!_ImgArr) {
        _ImgArr = [[NSArray alloc] initWithObjects:@"upDown", @"upDown", nil];
    }
    return _ImgArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [[NSArray alloc] initWithObjects:@"钱包", @"我的购买", nil];
    }
    return _titleArr;
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
