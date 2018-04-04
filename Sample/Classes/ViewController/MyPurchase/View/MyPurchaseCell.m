//
//  MyPurchaseCell.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseCell.h"
#import "MyPurchaseCellTopView.h"
#import "MyPurchaseCellListView.h"
#import "MyPurchaseSizeMacro.h"

@interface MyPurchaseCell()

@property (nonatomic, strong) UIView *bgContentView;  // 带圆角背景
@property (nonatomic, strong) MyPurchaseCellTopView *topView;  // 顶部透明区域
@property (nonatomic, strong) MyPurchaseCellListView *listView;

@end

@implementation MyPurchaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgContentView];
        [self.bgContentView addSubview:self.topView];
        [self.bgContentView addSubview:self.listView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.bgContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-gap_PurchaseCell_bottom_MyPurchase);
    }];
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(H_topView_myPurchaseCell);
    }];
    [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(weakSelf.bgContentView);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)testUpdateContent:(NSInteger)count
{
    [self.topView updateContentWithNameText:@"金牛座" count:@"2"];
    [self.listView testUpdateContent:count];
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

- (MyPurchaseCellListView *)listView
{
    if (!_listView) {
        _listView = [[MyPurchaseCellListView alloc] initWithFrame:CGRectZero];
    }
    return _listView;
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
