//
//  MyPurchaseCellTopView.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseCellTopView.h"

static CGFloat const W_Line_myPurchase = 3.f;

@interface MyPurchaseCellTopView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MyPurchaseCellTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(W_Line_myPurchase, 14.f));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineView.mas_right).offset(5.f);
        make.centerY.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContentWithNameText:(NSString *)name count:(NSString *)countStr
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@·%@张", CHANGE_TO_STRING(name), CHANGE_TO_STRING(countStr)];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = SRGBCOLOR_HEX(0x7B99FB);
        _lineView.layer.cornerRadius = W_Line_myPurchase/2.f;
        _lineView.clipsToBounds = YES;
    }
    return _lineView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = SRGBCOLOR_HEX(0x7B99FB);
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
