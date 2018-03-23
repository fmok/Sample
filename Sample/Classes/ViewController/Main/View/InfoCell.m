//
//  InfoCell.m
//  Sample
//
//  Created by wjy on 2018/3/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "InfoCell.h"

static CGFloat const gap_top_bottom = 20.f;
static CGFloat const gap_left_right = 10.f;
static CGFloat const W_H_headerImgView = 25.f;
static CGFloat const leftGap_header = 10.f;
static CGFloat const H_infoImgView = 0;

#define W_infoImgView (kScreenWidth/2.f-10.f*2)
#define H_infoImgView (W_infoImgView*2.f/3.f)

@interface InfoCell()

@property (nonatomic, strong) UIImageView *headerImgView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *infoImgView;

@end

@implementation InfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.headerImgView];
        [self addSubview:self.authorLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.infoImgView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(gap_left_right);
        make.top.equalTo(weakSelf).offset(gap_top_bottom);
        make.size.mas_equalTo(CGSizeMake(W_H_headerImgView, W_H_headerImgView));
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImgView.mas_right).offset(leftGap_header);
        make.top.equalTo(weakSelf.headerImgView);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImgView.mas_right).offset(leftGap_header);
        make.bottom.equalTo(weakSelf.headerImgView);
    }];
    
    [self.infoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-gap_left_right);
        make.top.equalTo(weakSelf.headerImgView.mas_bottom).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(W_infoImgView, H_infoImgView));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerImgView.mas_bottom).offset(10.f);
        make.left.equalTo(weakSelf).offset(gap_left_right);
        make.right.equalTo(weakSelf.infoImgView.mas_left).offset(-10.f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(gap_left_right);
        make.right.equalTo(weakSelf.infoImgView.mas_left).offset(-10.f);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10.f);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent:(CardInfoModel *)model
{
    
}

#pragma mark - Override methods
- (CGSize)sizeThatFits:(CGSize)size
{
    
    return size;
}

#pragma mark - getter & setter
- (UIImageView *)headerImgView
{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _headerImgView;
}

- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _authorLabel.font = [UIFont systemFontOfSize:10.f];
        _authorLabel.textColor = SRGBCOLOR_HEX(0x2f2f2f);
    }
    return _authorLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:8.f];
        _timeLabel.textColor = SRGBCOLOR_HEX(0x363636);
    }
    return _timeLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = SRGBCOLOR_HEX(0x000000);
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.textColor = SRGBCOLOR_HEX(0x363636);
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

- (UIImageView *)infoImgView
{
    if (!_infoImgView) {
        _infoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _infoImgView;
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
