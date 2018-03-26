//
//  MeViewController.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeViewController.h"
#import "MeControl.h"

@interface MeViewController ()

@property (nonatomic, strong) MeControl *control;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self customNav];
    WS(weakSelf);
    [self.view addSubview:self.mePulledTableView];
    [self.mePulledTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(44.f);
        } else {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(44.f);
        }
        make.left.and.right.and.bottom.equalTo(weakSelf.view);
    }];
    [self.control registerCell];
    [self.view bringSubviewToFront:self.zl_navigationBar];
}

#pragma mark - Private methods
- (void)customNav
{
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.title = @"我的账户";
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
        _mePulledTableView.backgroundColor = [UIColor whiteColor];
        _mePulledTableView.delegate = self.control;
        _mePulledTableView.dataSource = self.control;
    }
    return _mePulledTableView;
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
