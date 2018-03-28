//
//  HeaderView.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIView *tipsView;

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SRGBCOLOR_HEX(0xf5f6f8);
        [self addSubview:self.bgImgView];
        [self addSubview:self.tipsView];
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
    
    [super updateConstraints];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
