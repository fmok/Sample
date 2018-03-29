//
//  BuyDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "BuyDetailViewController.h"
#import "BuyDetailControl.h"

#define H_TopView (kScreenWidth*(120.f/375.f))

@interface BuyDetailViewController ()

@property (nonatomic, strong) BuyDetailControl *control;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation BuyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self configNavBarOpaque:YES];
    
    WS(weakSelf);
    [self.view addSubview:self.topImgView];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_TopView);
    }];
    
    [self.view addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(gap_left_right_buyDetail);
        make.right.equalTo(weakSelf.view).offset(-gap_left_right_buyDetail);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(44.f);
        } else {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(44.f);
        }
        make.height.mas_equalTo(H_Card);
    }];
    
    [self.view addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
//        if (@available(iOS 11.0, *)) {
//            make.bottom.equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom);
//        } else {
//            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide);
//        }
        make.height.mas_equalTo(kTabBarHeight);
    }];
    
    [self.control loadData];
}


#pragma mark - getter & setter
- (BuyDetailControl *)control
{
    if (!_control) {
        _control = [[BuyDetailControl alloc] init];
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

- (BuyDetailCardView *)cardView
{
    if (!_cardView) {
        _cardView = [[BuyDetailCardView alloc] initWithFrame:CGRectZero];
    }
    return _cardView;
}

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _buyBtn.backgroundColor = SRGBCOLOR_HEX(0x6075FB);
        [_buyBtn addTarget:self.control action:@selector(buyCardAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
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
