//
//  PetDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailViewController.h"
#import "PetDetailControl.h"
#import "FMTabsView.h"

#define H_TopView_PetDetail (kScreenWidth*(120.f/375.f))

@interface PetDetailViewController ()

@property (nonatomic, strong) PetDetailControl *control;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UILabel *petDesLabel;
@property (nonatomic, strong) FMTabsView *topTabView;

@end

@implementation PetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(weakSelf);
    [self.view addSubview:self.topImgView];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_TopView_PetDetail);
    }];
    [self.zl_navigationBar addSubview:self.petDesLabel];
    [self.petDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.zl_navigationBar);
        make.top.equalTo(weakSelf.zl_navigationBar.mas_bottom).offset(-8.f);
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
    [self.control loadData];
}

#pragma mark - Public methods
- (void)updatePetDes:(NSString *)petDes
{
    self.petDesLabel.text = CHANGE_TO_STRING(petDes);
}

- (void)updatePetTabs:(NSArray *)items
{
    self.topTabView.items = items;
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
