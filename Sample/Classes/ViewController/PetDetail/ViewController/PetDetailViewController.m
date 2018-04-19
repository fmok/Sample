//
//  PetDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailViewController.h"
#import "PetDetailControl.h"
#import "PetDetailBottomPetDesView.h"
#import "PetDetailFeedButton.h"

#define H_TopView_PetDetail (kScreenWidth*(120.f/375.f))

@interface PetDetailViewController ()

@property (nonatomic, strong) PetDetailControl *control;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UILabel *petDesLabel;
@property (nonatomic, strong) PetDetailBottomPetDesView *bottomPetDesView;
@property (nonatomic, strong) PetDetailFeedButton *feedButton;

@end

@implementation PetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.fm_navigationController setNavInteractivePopGestureType:ZLNavInteractivePopGestureTypeScreenEdgeLeft];
    WS(weakSelf);
    [self.view addSubview:self.topImgView];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_TopView_PetDetail);
    }];
    [self.fm_navigationBar addSubview:self.petDesLabel];
    [self.petDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.fm_navigationBar);
        make.top.equalTo(weakSelf.fm_navigationBar.mas_bottom).offset(-8.f);
    }];
    [self.view addSubview:self.topTabView];
    [self.topTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(kNavBarHeight+kGap_NavBarBottom);
        } else {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(kNavBarHeight+kGap_NavBarBottom);
        }
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(345.f, 49.f));
    }];
    [self.view addSubview:self.petScrollView];
    [self.petScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topTabView.mas_bottom).offset(10.f);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_CardsStackSingleCell);
    }];
    [self.view addSubview:self.bottomPetDesView];
    [self.bottomPetDesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.petScrollView.mas_bottom).offset(10.f);
        make.centerX.equalTo(weakSelf.view);
        CGFloat width = (kScreenWidth-2*Gap_CardsStackSingleCellEdges);
        CGFloat height = ((75.f/345.f)*width);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    [self.view addSubview:self.feedButton];
//    [self.feedButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.bottomPetDesView.mas_bottom).offset(20.f);
//        make.size.mas_equalTo(CGSizeMake(W_H_FeedButton, W_H_FeedButton));
//    }];
    
    [self.control loadData];
}

#pragma mark - Public methods
- (void)updatePetName:(NSString *)name petDes:(NSString *)petDes
{
    self.title = CHANGE_TO_STRING(name);
    self.petDesLabel.text = CHANGE_TO_STRING(petDes);
}

#pragma mark - Private methods
- (void)feedAction:(UIButton *)sender
{
    [self.feedButton feedButtonShakeAnimation:^(BOOL isFinished) {
        if (isFinished) {
            TTDPRINT(@"feed");
        }
    }];
}

#pragma mark - getter & setter
- (PetDetailControl *)control
{
    if (!_control) {
        _control = [[PetDetailControl alloc] init];
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

- (UILabel *)petDesLabel
{
    if (!_petDesLabel) {
        _petDesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _petDesLabel.backgroundColor = [UIColor clearColor];
        _petDesLabel.textColor = [UIColor whiteColor];
        _petDesLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _petDesLabel;
}

- (FMTabsView *)topTabView
{
    if (!_topTabView) {
        _topTabView = [[FMTabsView alloc] initWithFrame:CGRectZero];
        _topTabView.isNeedVerticalBar = YES;
        _topTabView.layer.cornerRadius = 10.f;
        _topTabView.clipsToBounds = YES;
    }
    return _topTabView;
}

- (FMCardsStackScrollView *)petScrollView
{
    if (!_petScrollView) {
        _petScrollView = [[FMCardsStackScrollView alloc] initWithFrame:CGRectZero];
        _petScrollView.cardStackScrollDelegate = self.control;
    }
    return _petScrollView;
}

- (PetDetailBottomPetDesView *)bottomPetDesView
{
    if (!_bottomPetDesView) {
        _bottomPetDesView = [[PetDetailBottomPetDesView alloc] initWithFrame:CGRectZero];
    }
    return _bottomPetDesView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (PetDetailFeedButton *)feedButton
{
    if (!_feedButton) {
        _feedButton = [[PetDetailFeedButton alloc] initWithFrame:CGRectMake((kScreenWidth-W_H_FeedButton)/2.f, kScreenHeight-W_H_FeedButton-40.f, W_H_FeedButton, W_H_FeedButton)];
        _feedButton.backgroundColor = SRGBCOLOR_HEX(0x167EFB);
        _feedButton.layer.cornerRadius = W_H_FeedButton/2.f;
        _feedButton.clipsToBounds = YES;
        [_feedButton setTitle:@"喂养" forState:UIControlStateNormal];
        [_feedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _feedButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
        [_feedButton addTarget:self action:@selector(feedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedButton;
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
