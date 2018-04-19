//
//  MeCell.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeCell.h"
#import "UIImageView+WebCache.h"

static CGFloat const leftImageW_H = 40.f;

@interface MeCell ()

@property (nonatomic, strong) UIImageView *bgContentView;
@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UILabel *contenLabel;

@end

@implementation MeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgContentView];
        [self.bgContentView addSubview:self.leftImgView];
        [self.bgContentView addSubview:self.contenLabel];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.bgContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(15.f);
        make.right.equalTo(weakSelf).offset(-15.f);
        make.top.equalTo(weakSelf).offset(10.f);
        make.bottom.equalTo(weakSelf);
    }];
    [self.leftImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgContentView).offset(10.f);
        make.centerY.equalTo(weakSelf.bgContentView);
        make.size.mas_equalTo(CGSizeMake(leftImageW_H, leftImageW_H));
    }];
    [self.contenLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImgView.mas_right).offset(20.f);
        make.centerY.equalTo(weakSelf.bgContentView);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContentWithImg:(NSString *)imgStr contentText:(NSString *)text
{
    self.leftImgView.image = [UIImage imageNamed:imgStr];
    self.contenLabel.text = CHANGE_TO_STRING(text);
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIImageView *)bgContentView
{
    if (!_bgContentView) {
        _bgContentView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgContentView.backgroundColor = [UIColor whiteColor];
        _bgContentView.layer.cornerRadius = 8.f;
        _bgContentView.clipsToBounds = YES;
    }
    return _bgContentView;
}

- (UIImageView *)leftImgView
{
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _leftImgView;
}

- (UILabel *)contenLabel
{
    if (!_contenLabel) {
        _contenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contenLabel.textColor = [UIColor blackColor];
        _contenLabel.font = [UIFont systemFontOfSize:17.f];
    }
    return _contenLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
