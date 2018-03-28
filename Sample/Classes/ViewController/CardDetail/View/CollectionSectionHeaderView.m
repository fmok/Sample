//
//  CollectionSectionHeaderView.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CollectionSectionHeaderView.h"

#define W_Line 4.f

@interface CollectionSectionHeaderView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation CollectionSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        [self addSubview:self.lineView];
        [self addSubview:self.textLabel];
        WS(weakSelf);
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10.f);
            make.bottom.equalTo(weakSelf).offset(-5.f);
            make.size.mas_equalTo(CGSizeMake(W_Line, 20.f));
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.lineView);
            make.left.equalTo(weakSelf.lineView).offset(10.f);
        }];
    }
    return self;
}

#pragma mark - getter & setter
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = SRGBCOLOR_HEX(0x7B99FB);
        _lineView.layer.cornerRadius = W_Line/2.f;
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

@end
