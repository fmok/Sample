//
//  CardStackSingleCell.m
//  Sample
//
//  Created by wjy on 2018/4/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CardStackSingleCell.h"
#import "UIImageView+WebCache.h"

@interface CardStackSingleCell ()

@property (nonatomic, strong) UIImageView *cardImgView;

@end

@implementation CardStackSingleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.cardImgView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.cardImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.width.mas_equalTo(W_CardsStackSingleCell);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContentWithImgUrl:(NSString *)imgUrl
{
    [self.cardImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIImageView *)cardImgView
{
    if (!_cardImgView) {
        _cardImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cardImgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
        _cardImgView.layer.cornerRadius = 10.f;
        _cardImgView.clipsToBounds = YES;
        _cardImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _cardImgView;
}

@end
