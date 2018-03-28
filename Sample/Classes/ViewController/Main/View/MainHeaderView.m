//
//  HeaderView.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MainHeaderView.h"

static CGFloat W_SignIn_Btn = 200.f;
static CGFloat H_SignIn_Btn = 40.f;

@interface MainHeaderView ()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIView *tipsView;
@property (nonatomic, strong) UIButton *signInBtn;

@end

@implementation MainHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SRGBCOLOR_HEX(0xf5f6f8);
        [self addSubview:self.bgImgView];
        [self addSubview:self.tipsView];
        [self addSubview:self.signInBtn];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    CGFloat H_bg = kScreenWidth*9.f/16.f;
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(H_bg);
    }];
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(15.f);
        make.right.equalTo(weakSelf).offset(-15.f);
        make.height.mas_equalTo(50.f);
    }];
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.tipsView.mas_top).offset(H_SignIn_Btn/2.f-4.f);
        make.centerX.equalTo(weakSelf.tipsView);
        make.size.mas_equalTo(CGSizeMake(W_SignIn_Btn, H_SignIn_Btn));
    }];
    
    [super updateConstraints];
}

#pragma mark - Events
- (void)tapSignIn:(UIButton *)sender
{
    TTDPRINT(@"签到");
}

#pragma mark - getter & setter
- (UIImageView *)bgImgView
{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImgView.backgroundColor = [UIColor purpleColor];
    }
    return _bgImgView;
}

- (UIView *)tipsView
{
    if (!_tipsView) {
        _tipsView = [[UIView alloc] initWithFrame:CGRectZero];
        _tipsView.backgroundColor = [UIColor whiteColor];
        _tipsView.layer.cornerRadius = 10.f;
        _tipsView.clipsToBounds = YES;
    }
    return _tipsView;
}

- (UIButton *)signInBtn
{
    if (!_signInBtn) {
        _signInBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _signInBtn.backgroundColor = [UIColor blueColor];
        _signInBtn.layer.cornerRadius = H_SignIn_Btn/2.f;
        _signInBtn.clipsToBounds = YES;
        [_signInBtn setTitle:@"签到" forState:UIControlStateNormal];
        _signInBtn.titleLabel.textColor = [UIColor whiteColor];
        _signInBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        [_signInBtn addTarget:self action:@selector(tapSignIn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signInBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
