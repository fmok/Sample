//
//  PetDetailTopTabView.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailTopTabView.h"

@interface PetDetailTopTabView ()
{
    UIColor *_bgColor;
    UIColor *_textColor;
    UIFont *_textFont;
    UIColor *_verticalBarColor;
}

@property (nonatomic, assign) BOOL isCreated;
@property (nonatomic, strong) NSMutableArray *tabsArr;

@end

@implementation PetDetailTopTabView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        self.isNeedVerticalBar = NO;
        self.isCreated = NO;
        _bgColor = [UIColor whiteColor];
        _textColor = SRGBCOLOR_HEX(0x7B99FB);
        _textFont = [UIFont systemFontOfSize:14.f];
        _verticalBarColor = _textColor;
    }
    return self;
}

#pragma mark - Public methods
- (void)initConfigurationBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont verticalBarColor:(UIColor *)verticalBarColor
{
    if (bgColor) {
        _bgColor = bgColor;
    }
    if (textColor) {
        _textColor = textColor;
    }
    if (textFont) {
        _textFont = textFont;
    }
    if (verticalBarColor) {
        _verticalBarColor = verticalBarColor;
    }
}

#pragma mark - Private methods
- (void)setUp
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.backgroundColor = _bgColor;
    CGFloat totalWidth = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat tabWidth = totalWidth/(CGFloat)self.items.count;
    [self.tabsArr removeAllObjects];
    for (NSInteger i = 0; i < self.items.count; i++) {
        @autoreleasepool {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*tabWidth, 0, tabWidth, height)];
            label.textColor = _textColor;
            label.font = _textFont;
            label.textAlignment = NSTextAlignmentCenter;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            label.text = CHANGE_TO_STRING([self.items objectAtIndex:i]);
            [self addSubview:label];
            [self.tabsArr addObject:label];
            if (_isNeedVerticalBar) {
                if (i < self.items.count-1) {
                    CGFloat barHeight = 16.5f;
                    CGFloat barWidth = .5f;
                    UIView *verticalBar = [[UIView alloc] initWithFrame:CGRectMake(label.ml_left+label.ml_width-barWidth, (height-barHeight)/2.f, barWidth, barHeight)];
                    verticalBar.backgroundColor = _verticalBarColor;
                    [self addSubview:verticalBar];
                }
            }
        }
    }
}

- (void)updateTabContent:(NSArray *)items
{
    if (items.count != _items.count) {
        @throw [NSException exceptionWithName:@"count error" reason:@"items内容个数必须和初始状态的一致" userInfo:nil];
    } else {
        _items = items;
        [self.tabsArr enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.text = CHANGE_TO_STRING([_items objectAtIndex:idx]);
        }];
    }
}

#pragma mark - getter & setter
- (void)setItems:(NSArray *)items
{
    if (!self.isCreated) {
        _items = items;
        [self setUp];
        self.isCreated = YES;
    } else {
        [self updateTabContent:items];
    }
}

- (NSMutableArray *)tabsArr
{
    if (!_tabsArr) {
        _tabsArr = [[NSMutableArray alloc] init];
    }
    return _tabsArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
