//
//  MyPurchaseCard.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseCard.h"
#import "MyPurchaseSizeMacro.h"

@interface MyPurchaseCard ()

@property (nonatomic, strong) UIImageView *cardImgView;
@property (nonatomic, strong) UILabel *growUpValue;
@property (nonatomic, strong) UILabel *restValue;

@end

@implementation MyPurchaseCard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1]
        self.backgroundColor = [UIColor clearColor];
        ;
        [self addSubview:self.cardImgView];
        [self addSubview:self.growUpValue];
        [self addSubview:self.restValue];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(weakSelf);
        make.height.mas_equalTo(H_MyPurchaseCardImgView);
    }];
    [self.growUpValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf.cardImgView.mas_bottom).offset(10.f);
    }];
    [self.restValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.cardImgView.mas_bottom).offset(10.f);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)testUpdateContent
{
    self.growUpValue.text = [NSString stringWithFormat:@"成长值：%@", @(100)];
    self.restValue.text = [NSString stringWithFormat:@"剩余：%@", @(99)];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIImageView *)cardImgView
{
    if (!_cardImgView) {
        _cardImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cardImgView.backgroundColor = [UIColor purpleColor];
        _cardImgView.layer.cornerRadius = 10.f;
        _cardImgView.clipsToBounds = YES;
    }
    return _cardImgView;
}

- (UILabel *)growUpValue
{
    if (!_growUpValue) {
        _growUpValue = [[UILabel alloc] initWithFrame:CGRectZero];
        _growUpValue.textColor = SRGBCOLOR_HEX(0x7B99FB);
        _growUpValue.font = [UIFont systemFontOfSize:12.f];
    }
    return _growUpValue;
}

- (UILabel *)restValue
{
    if (!_restValue) {
        _restValue = [[UILabel alloc] initWithFrame:CGRectZero];
        _restValue.textColor = SRGBCOLOR_HEX(0x666666);
        _restValue.font = [UIFont systemFontOfSize:12.f];
    }
    return _restValue;
}

@end
