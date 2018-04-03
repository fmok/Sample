//
//  CollectionSectionHeaderView.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CollectionSectionHeaderView.h"

static CGFloat const W_Line_main = 3.f;
static CGFloat const W_Btn_main = 50.f;
static CGFloat const H_Btn_main = 20.f;

static CGFloat const gap_left_right_main = 10.f;

@interface CollectionSectionHeaderView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *valueBtn;
@property (nonatomic, strong) UIButton *restBtn;

@end

@implementation CollectionSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView];
        [self addSubview:self.textLabel];
        [self addSubview:self.restBtn];
        [self addSubview:self.valueBtn];
        WS(weakSelf);
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(gap_left_right_main);
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(W_Line_main, 14.f));
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.lineView);
            make.left.equalTo(weakSelf.lineView).offset(gap_left_right_main);
        }];
        [self.restBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-gap_left_right_main);
            make.centerY.equalTo(weakSelf.lineView);
            make.size.mas_equalTo(CGSizeMake(W_Btn_main, H_Btn_main));
        }];
        [self.valueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.restBtn.mas_left).offset(-5);
            make.centerY.equalTo(weakSelf.lineView);
            make.size.mas_equalTo(CGSizeMake(W_Btn_main, H_Btn_main));
        }];
    }
    return self;
}

#pragma mark - Events
- (void)clickSort:(id)sender
{
    SortType type = SortTypeNULL;
    if (sender == self.valueBtn) {
        type = SortTypeByValue;
    } else if (sender == self.restBtn) {
        type = SortTypeBtRest;
    }
    if (type == SortTypeNULL) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sortByType:)]) {
        [self.delegate sortByType:type];
    }
}

#pragma mark - getter & setter
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = SRGBCOLOR_HEX(0x7B99FB);
        _lineView.layer.cornerRadius = W_Line_main/2.f;
        _lineView.clipsToBounds = YES;
    }
    return _lineView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.text = @"排序";
        _textLabel.textColor = SRGBCOLOR_HEX(0x7B99FB);
        _textLabel.font = [UIFont systemFontOfSize:18.f];
    }
    return _textLabel;
}

- (UIButton *)valueBtn
{
    if (!_valueBtn) {
        _valueBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _valueBtn.backgroundColor = [UIColor whiteColor];
        [_valueBtn setImage:[[UIImage imageNamed:@"upDown"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_valueBtn setTitle:@"价值" forState:UIControlStateNormal];
        _valueBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_valueBtn setTitleColor:SRGBCOLOR_HEX(0x7B99FB) forState:UIControlStateNormal];
        _valueBtn.layer.cornerRadius = H_Btn_main/2.f;
        [_valueBtn.layer setBorderColor:SRGBCOLOR_HEX(0x7B99FB).CGColor];
        [_valueBtn.layer setBorderWidth:1.f];
        CGFloat imageWidth = _valueBtn.imageView.image.size.width;
        CGFloat labelWidth = _valueBtn.titleLabel.bounds.size.width;
        _valueBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
        _valueBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
        [_valueBtn addTarget:self action:@selector(clickSort:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _valueBtn;
}

- (UIButton *)restBtn
{
    if (!_restBtn) {
        _restBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _restBtn.backgroundColor = [UIColor whiteColor];
        [_restBtn setImage:[[UIImage imageNamed:@"upDown"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_restBtn setTitle:@"剩余" forState:UIControlStateNormal];
        _restBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_restBtn setTitleColor:SRGBCOLOR_HEX(0x7B99FB) forState:UIControlStateNormal];
        _restBtn.layer.cornerRadius = H_Btn_main/2.f;
        [_restBtn.layer setBorderColor:SRGBCOLOR_HEX(0x7B99FB).CGColor];
        [_restBtn.layer setBorderWidth:1.f];
        CGFloat imageWidth = _restBtn.imageView.image.size.width;
        CGFloat labelWidth = _restBtn.titleLabel.bounds.size.width;
        _restBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
        _restBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
        [_restBtn addTarget:self action:@selector(clickSort:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _restBtn;
}

@end
