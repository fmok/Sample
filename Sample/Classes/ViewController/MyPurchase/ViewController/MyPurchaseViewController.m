//
//  MyPurchaseViewController.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseViewController.h"
#import "MyPurchaseControl.h"

#define H_TopView_MyPurchase (kScreenWidth*(120.f/375.f))

@interface MyPurchaseViewController ()

@property (nonatomic, strong) MyPurchaseControl *control;
@property (nonatomic, strong) UIImageView *topImgView;

@end

@implementation MyPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(weakSelf);
    [self.view addSubview:self.topImgView];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_TopView_MyPurchase);
    }];
    
    [self.view addSubview:self.pulledTableView];
    [self.pulledTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view).offset(gap_left_right_myPurchase);
        make.right.equalTo(weakSelf.view).offset(-gap_left_right_myPurchase);
        make.bottom.equalTo(weakSelf.view);
    }];
    [self.control registerCell];
    [self.control loadData];
}

#pragma mark - getter & setter
- (MyPurchaseControl *)control
{
    if (!_control) {
        _control = [[MyPurchaseControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (UIImageView *)topImgView
{
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _topImgView.backgroundColor = [UIColor purpleColor];
    }
    return _topImgView;
}

- (PulledTableView *)pulledTableView
{
    if (!_pulledTableView) {
        _pulledTableView = [[PulledTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _pulledTableView.backgroundColor = [UIColor clearColor];
        _pulledTableView.delegate = self.control;
        _pulledTableView.dataSource = self.control;
        _pulledTableView.showsVerticalScrollIndicator = NO;
        _pulledTableView.isHeader = NO;
        _pulledTableView.isFooter = NO;
        _pulledTableView.estimatedRowHeight = 0;
        _pulledTableView.estimatedSectionHeaderHeight = 0;
        _pulledTableView.estimatedSectionFooterHeight = 0;
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-2*gap_left_right_myPurchase, (IS_IPHONEX?44.f:64.f)+kGap_NavBarBottom)];
        header.backgroundColor = [UIColor clearColor];
        _pulledTableView.tableHeaderView = header;
    }
    return _pulledTableView;
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
