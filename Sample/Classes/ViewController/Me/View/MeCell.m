//
//  MeCell.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeCell.h"

@interface MeCell ()

@property (nonatomic, strong) UIImageView *bgContentView;

@end

@implementation MeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgContentView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(15.f);
        make.right.equalTo(weakSelf).offset(-15.f);
        make.top.equalTo(weakSelf).offset(10.f);
        make.bottom.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent
{
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
