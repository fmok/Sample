//
//  MyPurchaseViewController.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseViewController.h"
#import "MyPurchaseControl.h"

#define H_TopView (kScreenWidth*(120.f/375.f))

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
        make.height.mas_equalTo(H_TopView);
    }];
    [self.view addSubview:self.pulledCollectionView];
    [self.pulledCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(kNavBarHeight);
        } else {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(kNavBarHeight);
        }
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

- (PulledCollectionView *)pulledCollectionView
{
    if (!_pulledCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _pulledCollectionView = [[PulledCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _pulledCollectionView.backgroundColor = [UIColor whiteColor];
        _pulledCollectionView.bounces = YES;
        _pulledCollectionView.alwaysBounceVertical = YES;
        _pulledCollectionView.showsVerticalScrollIndicator = NO;
        _pulledCollectionView.delegate = self.control;
        _pulledCollectionView.dataSource = self.control;
        _pulledCollectionView.isHeader = NO;
        _pulledCollectionView.isFooter = NO;
        _pulledCollectionView.layer.cornerRadius = 10.f;
        _pulledCollectionView.clipsToBounds = YES;
    }
    return _pulledCollectionView;
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
