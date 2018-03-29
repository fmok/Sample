//
//  BuyDetailCardView.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "BuyDetailCardView.h"
#import "UIImageView+WebCache.h"

static CGFloat const H_costLabel = 22.f;

@interface BuyDetailCardView ()

@property (nonatomic, strong) UIImageView *cardImgView;
@property (nonatomic, strong) UILabel *costLabel;

@end

@implementation BuyDetailCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        [self addSubview:self.cardImgView];
        [self addSubview:self.costLabel];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(7.f);
        make.bottom.equalTo(weakSelf).offset(-7.f);
        make.height.mas_equalTo(H_costLabel);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContentWithCardImgUrl:(NSString *)imgUrl cost:(NSString *)cost
{
    [self.cardImgView sd_setImageWithURL:[NSURL URLWithString:CHANGE_TO_STRING(imgUrl)] placeholderImage:nil options:SDWebImageRetryFailed];
    self.costLabel.text = [NSString stringWithFormat:@" %@LUK ", CHANGE_TO_STRING(cost)];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIImageView *)cardImgView
{
    if (!_cardImgView) {
        _cardImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cardImgView.contentMode = UIViewContentModeScaleAspectFill;
        _cardImgView.backgroundColor = [UIColor orangeColor];
    }
    return _cardImgView;
}

- (UILabel *)costLabel
{
    if (!_costLabel) {
        _costLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _costLabel.backgroundColor = [UIColor whiteColor];
        _costLabel.font = [UIFont systemFontOfSize:15.f];
        _costLabel.textColor = SRGBCOLOR_HEX(0x8ABAFF);
        _costLabel.layer.cornerRadius = H_costLabel/2.f;
        _costLabel.clipsToBounds = YES;
    }
    return _costLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
