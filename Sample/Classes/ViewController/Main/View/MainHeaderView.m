//
//  HeaderView.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MainHeaderView.h"
#import "FMScrollLabel.h"

#define W_SignIn_Btn kScreenWidth/2.f
#define H_SignIn_Btn 40.f
static CGFloat const W_H_trumpetImgView = 20.f;
static CGFloat const gap_tips_left_right = 15.f;

@interface MainHeaderView ()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIView *tipsView;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, strong) UIImageView *trumpetImgView;  // 喇叭
@property (nonatomic, strong) FMScrollLabel *scrollLabel;

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
        [self.tipsView addSubview:self.trumpetImgView];
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
        make.left.equalTo(weakSelf).offset(gap_tips_left_right);
        make.right.equalTo(weakSelf).offset(-gap_tips_left_right);
        make.height.mas_equalTo(55.f);
    }];
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.tipsView.mas_top).offset(H_SignIn_Btn/2.f-8.f);
        make.centerX.equalTo(weakSelf.tipsView);
        make.size.mas_equalTo(CGSizeMake(W_SignIn_Btn, H_SignIn_Btn));
    }];
    [self.trumpetImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tipsView).offset(12.f);
        make.bottom.equalTo(weakSelf.tipsView).offset(-12.f);
        make.size.mas_equalTo(CGSizeMake(W_H_trumpetImgView, W_H_trumpetImgView));
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent
{
    if (!_scrollLabel) {
        CGFloat scroll_X = gap_tips_left_right+W_H_trumpetImgView+12.f;
        CGFloat scroll_Y = self.trumpetImgView.ml_top;
        CGFloat scroll_W = self.tipsView.ml_width-2*gap_tips_left_right-W_H_trumpetImgView-12.f;
        _scrollLabel = [[FMScrollLabel alloc] initWithFrame:CGRectMake(scroll_X, scroll_Y, scroll_W, W_H_trumpetImgView)];
        [self.tipsView addSubview:_scrollLabel];
    } 
    _scrollLabel.text = @"每天上午9:00系统发放100LUK，抢完为止！";
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - Events
- (void)tapSignIn:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(siginAction)]) {
        [self.delegate siginAction];
    }
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

- (UIImageView *)trumpetImgView
{
    if (!_trumpetImgView) {
        _trumpetImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _trumpetImgView.backgroundColor = [UIColor redColor];
    }
    return _trumpetImgView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
