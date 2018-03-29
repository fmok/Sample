//
//  MeHeaderView.m
//  Sample
//
//  Created by wjy on 2018/3/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeHeaderView.h"

@interface MeHeaderView ()

@property (nonatomic, strong) UILabel *LUKLabel;
@property (nonatomic, strong) UILabel *accountLabel;

@end

@implementation MeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.imgView];
        [self addSubview:self.LUKLabel];
        [self addSubview:self.accountLabel];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.LUKLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
    }];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.LUKLabel.mas_bottom).offset(20.f);
        make.centerX.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent
{
    self.LUKLabel.text = CHANGE_TO_STRING(@"10000000.03LUK");
    self.accountLabel.text = [NSString stringWithFormat:@"当前账户：%@", CHANGE_TO_STRING(@"13711111111")];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.backgroundColor = [UIColor purpleColor];
    }
    return _imgView;
}

- (UILabel *)LUKLabel
{
    if (!_LUKLabel) {
        _LUKLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _LUKLabel.textColor = [UIColor whiteColor];
        _LUKLabel.font = [UIFont boldSystemFontOfSize:40.f];
    }
    return _LUKLabel;
}

- (UILabel *)accountLabel
{
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _accountLabel.textColor = [UIColor whiteColor];
        _accountLabel.font = [UIFont systemFontOfSize:20.f];
    }
    return _accountLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
