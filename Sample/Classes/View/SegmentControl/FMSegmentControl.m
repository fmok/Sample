//
//  FMSegmentControl.m
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMSegmentControl.h"

@interface FMMaskView : UIView

@property (nonatomic, strong) CAShapeLayer *maskView;

@end

@implementation FMMaskView

- (CAShapeLayer *)maskView {
    if (!_maskView) {
        _maskView = [[CAShapeLayer alloc] init];
    }
    return _maskView;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.maskView.path = [UIBezierPath bezierPathWithRect:frame].CGPath;
}

@end


@interface FMSegmentControl ()
{
    UIColor *titleColorNormal;
    UIColor *titleColorSelected;
    UIFont *titleFont;
    
    UIColor *segBgColorNormal;
    UIColor *segBgColorSelected;
    
    UIColor *borderColor;
    CGFloat cornerRadius;
    CGFloat borderWidth;
}

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) FMMaskView *indicatorView;
@property (nonatomic, strong) UIView *titleLabelsView;
@property (nonatomic, strong) UIView *selectedTitlesLabelView;
@property (nonatomic, assign) CGRect firstItemFrame;

@end

@implementation FMSegmentControl

- (void)dealloc
{
}

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        [self commitInit];
        self.backgroundColor = segBgColorNormal;
        [self setUp];
        self.items = items;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    _titleLabelsView.frame = self.bounds;
    _selectedTitlesLabelView.frame = self.bounds;
    
    CGFloat width = CGRectGetWidth(self.bounds)/self.items.count;
    
    for (int i = 0; i < self.items.count; i ++) {
        _titleLabelsView.subviews[i].frame = CGRectMake(width * i, 0, width, CGRectGetHeight(self.bounds));
        _selectedTitlesLabelView.subviews[i].frame = CGRectMake(width * i, 0, width, CGRectGetHeight(self.bounds));
    }
    
    _indicatorView.frame = [self elementFrameAtIndex:self.currentIndex];
    _indicatorView.layer.cornerRadius = cornerRadius;
}

#pragma mark - Publice Method
- (void)commitInitWithTitleNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor font:(UIFont *)font
{
    titleColorNormal = normalColor;
    titleColorSelected = selectedColor;
    titleFont = font;
}

- (void)commitInitWithSegBgColorNormal:(UIColor *)segBgNormal segBgColorSelected:(UIColor *)segBgSelected
{
    segBgColorNormal = segBgNormal;
    segBgColorSelected = segBgSelected;
}

- (void)commitInitWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    borderColor = borderColor;
    borderWidth = borderWidth;
    cornerRadius = cornerRadius;
}

- (void)scrollToIndex:(NSInteger)index
{
    if (self.currentIndex == index) {
        return;
    }
    [self moveIndicatorViewToIndex:index];
}

- (void)scrollByProgress:(CGFloat)progress
{
    [self moveIndicatorViewByProgress:progress];
}

#pragma mark - Private methods
- (void)commitInit
{
    // default
    [self commitInitWithSegBgColorNormal:SRGBCOLOR_HEX(0x6075FB) segBgColorSelected:SRGBCOLOR_HEX(0xBED2EF)];
    [self commitInitWithTitleNormalColor:[UIColor whiteColor] selectedColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14.f]];
    [self commitInitWithBorderColor:[UIColor clearColor] borderWidth:0 cornerRadius:0];
}

- (void)setUp
{
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.titleLabelsView];
    [self addSubview:self.indicatorView];
    
    [self addSubview:self.selectedTitlesLabelView];
    _selectedTitlesLabelView.layer.mask = self.indicatorView.maskView;
    //
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGR];
}

- (void)addLabels
{
    for (int i = 0; i < self.items.count; i ++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.items[i];
        titleLabel.font = titleFont;
        titleLabel.textColor = titleColorNormal;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabelsView addSubview:titleLabel];
        
        UILabel *selectedTitleLabel = [[UILabel alloc] init];
        selectedTitleLabel.text = self.items[i];
        selectedTitleLabel.font = titleFont;
        selectedTitleLabel.textColor = titleColorSelected;
        selectedTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_selectedTitlesLabelView addSubview:selectedTitleLabel];
    }
    
    [self setNeedsLayout];
}

- (CGRect)elementFrameAtIndex:(NSInteger)index
{
    return ((UILabel *)self.titleLabels[index]).frame;
}

- (NSInteger)nearestElementIndex:(CGPoint)postion
{
    NSArray *temp = self.titleLabelsView.subviews;
    postion.y = self.ml_height * 0.5;
    for (int i = 0; i < temp.count; i ++) {
        UIView *view = temp[i];
        CGRect frame = view.frame;
        if (CGRectContainsPoint(frame, postion)) {
            return i;
        }
    }
    return 0;
}

- (void)moveIndicatorViewToIndex:(NSInteger)index
{
    _currentIndex = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControl:didSeletedItemAtIndex:)]) {
        [self.delegate segmentedControl:self didSeletedItemAtIndex:index];
    }
    
    [self moveIndicatorView];
}

- (void)moveIndicatorViewByProgress:(CGFloat)progress
{
    self.currentIndex = (int)progress;
    CGRect frame = self.firstItemFrame;
    CGFloat width = CGRectGetWidth(self.bounds)/self.items.count;
    frame.origin.x += width * progress;
    self.indicatorView.frame = frame;
}

- (void)moveIndicatorView
{
    self.indicatorView.frame = ((UILabel *)self.titleLabels[self.currentIndex]).frame;
    [self layoutIfNeeded];
}

#pragma mark - Action handlers
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint loaction = [gestureRecognizer locationInView:self];
    NSInteger index = [self nearestElementIndex:loaction];
    [self moveIndicatorViewToIndex:index];
}

#pragma mark - Getter & Setter
- (CGRect)firstItemFrame
{
    return [self.titleLabels[0] frame];
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self addLabels];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self moveIndicatorView];
}

- (UIView *)titleLabelsView
{
    if (!_titleLabelsView) {
        _titleLabelsView = [[UIView alloc] init];
    }
    return _titleLabelsView;
}

- (NSArray *)titleLabels
{
    return self.titleLabelsView.subviews;
}

- (UIView *)selectedTitlesLabelView
{
    if (!_selectedTitlesLabelView) {
        _selectedTitlesLabelView = [[UIView alloc] init];
    }
    return _selectedTitlesLabelView;
}

- (FMMaskView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[FMMaskView alloc] init];
        _indicatorView.backgroundColor = segBgColorSelected;
        _indicatorView.layer.masksToBounds = YES;
    }
    return _indicatorView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
