//
//  CardDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MainViewController.h"
#import "MainControl.h"

@interface MainViewController ()

@property (nonatomic, strong) MainControl *control;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self configNavBarBackgroundImage:[UIImage imageNamed:@"nav.png"]];
    self.zl_automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = SRGBCOLOR_HEX(0xf5f6f8);
    WS(weakSelf);
    [self.view addSubview:self.headerView];
    CGFloat H_header = kScreenWidth*9.f/16.f+20.f;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_header);
    }];
    [self.view addSubview:self.pulledCollectionView];
    [self.pulledCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.mas_bottom).offset(10.f);
        make.bottom.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view).offset(Insert_left_right);
        make.right.equalTo(weakSelf.view).offset(-Insert_left_right);
    }];
    [self.control registerCell];
}

#pragma mark - getter & setter
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
        _pulledCollectionView.pulledDelegate = self.control;
        _pulledCollectionView.isHeader = YES;
        _pulledCollectionView.isFooter = NO;
        _pulledCollectionView.layer.cornerRadius = 10.f;
        _pulledCollectionView.clipsToBounds = YES;
    }
    return _pulledCollectionView;
}

- (MainControl *)control
{
    if (!_control) {
        _control = [[MainControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (MainHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MainHeaderView alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
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
