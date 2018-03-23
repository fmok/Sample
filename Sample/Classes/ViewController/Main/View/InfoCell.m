//
//  InfoCell.m
//  Sample
//
//  Created by wjy on 2018/3/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "InfoCell.h"
#import "UIImageView+WebCache.h"
#import "JSONKit.h"

static CGFloat const gap_top_bottom = 20.f;
static CGFloat const gap_left_right = 15.f;
static CGFloat const W_H_headerImgView = 25.f;
static CGFloat const leftGap_header = 10.f;

#define W_infoImgView (kScreenWidth/2.f-10.f*2)
#define H_infoImgView (W_infoImgView*2.f/3.f)

@interface InfoCell()
{
    BOOL isHaveInfoImg;
}

@property (nonatomic, strong) UIImageView *headerImgView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *infoImgView;

@property (nonatomic, strong) UIView *bottomLine;

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
        [self addSubview:self.bottomLine];
        isHaveInfoImg = NO;
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.headerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(gap_left_right);
        make.top.equalTo(weakSelf).offset(gap_top_bottom);
        make.size.mas_equalTo(CGSizeMake(W_H_headerImgView, W_H_headerImgView));
    }];
    
    [self.authorLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImgView.mas_right).offset(leftGap_header);
        make.top.equalTo(weakSelf.headerImgView);
    }];
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImgView.mas_right).offset(leftGap_header);
        make.bottom.equalTo(weakSelf.headerImgView);
    }];
    
    [self.infoImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-gap_left_right);
        make.top.equalTo(weakSelf.headerImgView.mas_bottom).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(W_infoImgView, H_infoImgView));
    }];
    
#warning todo remake 方法待优化
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerImgView.mas_bottom).offset(10.f);
        make.left.equalTo(weakSelf).offset(gap_left_right);
        if (isHaveInfoImg) {
            make.right.equalTo(weakSelf.infoImgView.mas_left).offset(-10.f);
        } else {
            make.right.equalTo(weakSelf).offset(-gap_left_right);
        }
//        if (isHaveInfoImg) {
//            make.right.equalTo(weakSelf).offset(-(weakSelf.infoImgView.frame.size.width+10+gap_left_right));
//        } else {
//            make.right.equalTo(weakSelf).offset(-gap_left_right);
//        }
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10.f);
        make.left.equalTo(weakSelf).offset(gap_left_right);
        if (isHaveInfoImg) {
            make.right.equalTo(weakSelf.infoImgView.mas_left).offset(-10.f);
        } else {
            make.right.equalTo(weakSelf).offset(-gap_left_right);
        }
//        if (isHaveInfoImg) {
//            make.right.equalTo(weakSelf).offset(-(weakSelf.infoImgView.frame.size.width+10+gap_left_right));
//        } else {
//            make.right.equalTo(weakSelf).offset(-gap_left_right);
//        }
    }];
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(gap_left_right);
        make.right.equalTo(weakSelf).offset(-gap_left_right);
        make.bottom.equalTo(weakSelf);
        make.height.mas_equalTo(.5f);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent:(CardInfoModel *)model
{
    //
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:CHANGE_TO_STRING(model.cc_icon)] placeholderImage:nil options:SDWebImageRetryFailed];
    //
    self.authorLabel.text = CHANGE_TO_STRING(model.uname);
    //
    self.timeLabel.text = CHANGE_TO_STRING(model.addTime);
    //
    NSArray *imageUrls = [model.img_url objectFromJSONString];
    NSString *imgUrl = CHANGE_TO_STRING([imageUrls firstObject]);
    isHaveInfoImg = ![FMUtility isEmptyString:imgUrl];
    self.infoImgView.hidden = !isHaveInfoImg;
    [self.infoImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil options:SDWebImageRetryFailed];
    //
    self.titleLabel.text = @"这个标题特别的长这个标题特别的长这个标题特别的长这个标题特别的长这个标题特别的长这个标题特别的长这个标题特别的长这个标题特别的长这个标题特别的长";//CHANGE_TO_STRING(model.text);
    //
    self.contentLabel.text = @"这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长这个内容特别的长";//CHANGE_TO_STRING(model.desc);
    self.contentLabel.numberOfLines = (isHaveInfoImg ? 4 : 0);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
#pragma mark - Override methods
- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0.f;
    totalHeight += gap_top_bottom;
    totalHeight += W_H_headerImgView;
    totalHeight += 10.f;
    if (isHaveInfoImg) {
        totalHeight += H_infoImgView;
    } else {
        CGSize contentSize = size;
        contentSize.width -= gap_left_right*2.f;
        totalHeight += [self.titleLabel sizeThatFits:contentSize].height;
        totalHeight += 10.f;
        totalHeight += [self.contentLabel sizeThatFits:contentSize].height;
    }
    totalHeight += gap_top_bottom;
    return CGSizeMake(size.width, totalHeight);
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
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
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
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    }
    return _contentLabel;
}

- (UIImageView *)infoImgView
{
    if (!_infoImgView) {
        _infoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _infoImgView.backgroundColor = [UIColor grayColor];
    }
    return _infoImgView;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = SRGBCOLOR_HEX(0xececec);
    }
    return _bottomLine;
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
