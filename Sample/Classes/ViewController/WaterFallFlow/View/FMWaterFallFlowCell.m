//
//  FMWaterFallFlowCell.m
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMWaterFallFlowCell.h"
#import "UIImageView+WebCache.h"

@interface FMWaterFallFlowCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation FMWaterFallFlowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8.f;
        self.clipsToBounds = YES;
        [self addSubview:self.imgView];
        [self addSubview:self.priceLabel];
    }
    return self;
}

- (void)updateConstraints
{
    // 尽量减少使用 平级子控件之间 的约束
    WS(weakSelf);
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-30.f);
    }];
    [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(weakSelf);
        make.height.mas_equalTo(30.f);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContentWithImgUrl:(NSString *)imgUrlStr price:(NSString *)priceStr
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    self.priceLabel.text = CHANGE_TO_STRING(priceStr);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.backgroundColor = [UIColor lightGrayColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = [UIFont systemFontOfSize:17.f];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}

@end
