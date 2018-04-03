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
@property (nonatomic, strong) UIView *bgContentView;
@property (nonatomic, strong) CollectionSectionHeaderView *sectionHeaderView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self configNavBarBackgroundImage:[UIImage imageNamed:@"nav.png"]];
    self.zl_automaticallyAdjustsScrollViewInsets = NO;
    
    WS(weakSelf);
    [self.view addSubview:self.headerView];
    CGFloat H_header = kScreenWidth*9.f/16.f+20.f;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_header);
    }];
    
    [self.view addSubview:self.bgContentView];
    [self.bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.mas_bottom).offset(10.f);
        make.bottom.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view).offset(gap_left_right_main);
        make.right.equalTo(weakSelf.view).offset(-gap_left_right_main);
    }];
    
    [self.bgContentView addSubview:self.sectionHeaderView];
    [self.sectionHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgContentView).offset(8.5f);
        make.left.and.right.equalTo(weakSelf.bgContentView);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.bgContentView addSubview:self.pulledCollectionView];
    [self.pulledCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sectionHeaderView.mas_bottom);
        make.bottom.and.left.and.right.equalTo(weakSelf.bgContentView);
    }];
    [self.control registerCell];
    [self.control loadData];
}

#pragma mark - getter & setter
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
        _headerView.delegate = self.control;
    }
    return _headerView;
}

- (UIView *)bgContentView
{
    if (!_bgContentView) {
        _bgContentView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgContentView.backgroundColor = [UIColor whiteColor];
        _bgContentView.layer.cornerRadius = 10.f;
        _bgContentView.clipsToBounds = YES;
    }
    return _bgContentView;
}

- (CollectionSectionHeaderView *)sectionHeaderView
{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[CollectionSectionHeaderView alloc] initWithFrame:CGRectZero];
        _sectionHeaderView.delegate = self.control;
    }
    return _sectionHeaderView;
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
        _pulledCollectionView.pulledDelegate = self.control;
        _pulledCollectionView.isHeader = YES;
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
