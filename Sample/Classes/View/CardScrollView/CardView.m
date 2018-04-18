//
//  CardView.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CardView.h"
#import "UIImageView+WebCache.h"

@interface CardView ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
        WS(weakSelf);
        [self addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(frame.size.width, frame.size.height));
        }];
    }
    return self;
}

#pragma mark - Public methods
- (void)updateContent:(NSString *)imgUrl
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

#pragma mark - getter & setter
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end
