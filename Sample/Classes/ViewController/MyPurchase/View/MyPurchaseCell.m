//
//  MyPurchaseCell.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseCell.h"
#import "MyPurchaseCellTopView.h"

static CGFloat const H_topView_myPurchaseCell = 32.f;

@interface MyPurchaseCell()

@property (nonatomic, strong) UIView *bgContentView;
@property (nonatomic, strong) MyPurchaseCellTopView *topView;

@end

@implementation MyPurchaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgContentView];
        [self.bgContentView addSubview:self.topView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-12.f);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(H_topView_myPurchaseCell);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent
{
    [self.topView updateContentWithNameText:@"金牛座" count:@"2"];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter & setter
- (UIView *)bgContentView
{
    if (!_bgContentView) {
        _bgContentView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgContentView.backgroundColor = [UIColor whiteColor];
        _bgContentView.layer.cornerRadius = 10.f;
        _bgContentView.clipsToBounds = YES;
    }
    return _bgContentView;
}

- (MyPurchaseCellTopView *)topView
{
    if (!_topView) {
        _topView = [[MyPurchaseCellTopView alloc] initWithFrame:CGRectZero];
    }
    return _topView;
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
