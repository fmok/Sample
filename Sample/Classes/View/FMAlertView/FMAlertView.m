//
//  FMAlertView.m
//  Sample
//
//  Created by wjy on 2018/3/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMAlertView.h"

static CGFloat const backgroundAlpha = 0.5;
#define gap_left_right 15.f

@interface FMAlertView()

@property(nonatomic, strong) UIView *mainView;  // 弹窗 view
@property(nonatomic, strong) UILabel *headerTitleLabel;  // 头部的标题 label
@property(nonatomic, strong) UILabel *contentTextLabel;  // 弹窗内容 label
@property(nonatomic, strong) UIButton *closedButton;  // 关闭按钮 button
@property(nonatomic, strong) UIButton *confirmButton;  // 确认按钮 button
@property(nonatomic, strong) UIButton *cancelButton;  // 取消按钮 button

@end

@implementation FMAlertView

#pragma mark - Init
- (instancetype)initWithStyle:(AlertStyle)style {
    self = [super init];
    if (self) {
        [self initWindow:style];
    }
    return self;
}

- (instancetype)initWithStyle:(AlertStyle)style width:(CGFloat)width{
    self = [super init];
    if (self) {
        [self initWindow:style];
        [self setAlertWidth:width];
    }
    return self;
}

- (void)initWindow:(AlertStyle)style
{
    [self viewInitUI];
    
    switch (style) {
        case AlertStyleSimpleAlert:
            [self simpleAlertViewInitUI];
            break;
        case AlertStyleConfirmAlert:
            [self confirmAlertViewInitUI];
            
            break;
        case AlertStyleCancelAndConfirmAlert:
            [self cancelAndConfirmAlertViewInitUI];
            break;
    }
}

/**
 view 初始化
 */
- (void)viewInitUI
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:backgroundAlpha]];
    [window addSubview:self];
    
    [self addSubview:self.mainView];
    [self.mainView insertSubview:self.closedButton atIndex:999];
    [self.mainView addSubview:self.headerTitleLabel];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.mainView.superview);
        make.width.offset([UIScreen mainScreen].bounds.size.width * 0.7);
    }];
    
    [self.closedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView);
        make.right.equalTo(self.mainView);
        make.width.height.offset(35);
    }];
    [self.headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView).offset(37.5f);
        make.left.equalTo(self.mainView).offset(15.f);
        make.right.equalTo(self.mainView).offset(-15.f);
    }];
}

#pragma mark - Public methods
- (void)setTitleText:(NSString *)title contentText:(NSString *)content confirmBtnText:(NSString *)confirmText cancelBtnText:(NSString *)cancelText
{
    self.headerTitleLabel.text = CHANGE_TO_STRING(title);
    self.contentTextLabel.attributedText = [self attributedStringForString:content lineSpacing:5];
    [self.confirmButton setTitle:confirmText forState:UIControlStateNormal];
    [self.cancelButton setTitle:cancelText forState:UIControlStateNormal];
}

- (void)show
{
    [self animate];
}

#pragma mark - Private methods
/**
 无按钮  弹窗样式
 */
- (void)simpleAlertViewInitUI
{
    [self.contentTextLabel sizeToFit];
    
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerTitleLabel.mas_bottom).offset(23.f);
        make.left.equalTo(self.mainView).offset(gap_left_right);
        make.right.equalTo(self.mainView).offset(-gap_left_right);
        make.bottom.equalTo(self.mainView).offset(-23.f);
    }];
}

/**
 只有确认按钮 的弹窗样式
 */
- (void)confirmAlertViewInitUI
{
    [self.mainView addSubview:self.confirmButton];
    [self.mainView addSubview:self.contentTextLabel];
    
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerTitleLabel.mas_bottom).offset(23.f);
        make.left.equalTo(self.mainView).offset(gap_left_right);
        make.right.equalTo(self.mainView).offset(-gap_left_right);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextLabel.mas_bottom).offset(28.f);
        make.left.right.equalTo(self.mainView);
        make.bottom.equalTo(self.mainView);
        make.height.offset(55.f);
    }];
}

/**
 有取消 按钮 和 确认按钮的弹窗样式
 */
- (void)cancelAndConfirmAlertViewInitUI
{
    [self.mainView addSubview:self.cancelButton];
    [self.mainView addSubview:self.confirmButton];
    [self.mainView addSubview:self.contentTextLabel];
    
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerTitleLabel.mas_bottom).offset(23.f);
        make.left.equalTo(self.mainView).offset(gap_left_right);
        make.right.equalTo(self.mainView).offset(-gap_left_right);
    }];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    [arrayM addObject:self.cancelButton];
    [arrayM addObject:self.confirmButton];
    
    [arrayM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [arrayM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(55.f);
        make.bottom.equalTo(self.mainView);
        make.top.equalTo(self.contentTextLabel.mas_bottom).offset(30);
    }];
}

/**
 设置弹框的宽度
 @param width width 宽度值  范围 0-1  百分比
 */
- (void)setAlertWidth:(CGFloat)width
{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (width > 1) {
            make.width.offset(width);
        } else if(width > 0 && width <= 1){
            make.width.offset([UIScreen mainScreen].bounds.size.width * width);
        } else{
            make.width.offset([UIScreen mainScreen].bounds.size.width * 0.7);
        }
    }];
}

- (NSMutableAttributedString *)attributedStringForString:(NSString *)str lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    return attributedString;
}

#pragma mark - Animation
- (void)animate
{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [UIView animateWithDuration:0.1 animations:^{
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:backgroundAlpha]];
    }];
    
    self.mainView.transform = CGAffineTransformMakeScale(0.4, 0.4);
    [UIView animateWithDuration:0.15 animations:^{
        self.mainView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

#pragma make - Events
- (void)exit
{
    [self removeFromSuperview];
}

- (void)closedButtonClick:(UIButton *)sender
{
    [self exit];
}

- (void)confirmButtonClick:(UIButton*)sender
{
    if(self.confirm) {
        self.confirm();
    }
    [self exit];
}

- (void)cancelButtonClick:(UIButton*)sender
{
    if(self.cancel) {
        self.cancel();
    }
    [self exit];
}

#pragma make getter & setter
/**
 单击 背景 是否关闭弹窗
 */
- (void)setIsClickBackgroundCloseWindow:(BOOL)isClickBackgroundCloseWindow
{
    if (isClickBackgroundCloseWindow) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exit)];
        [self addGestureRecognizer:tapGesture];
    }
}

/**
 设置 确认按钮背景
 */
- (void)setConfirmBackgroundColor:(UIColor *)confirmBackgroundColor
{
    [self.confirmButton setBackgroundColor:confirmBackgroundColor];
}

- (UIView*)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]init];
        [_mainView setBackgroundColor:[UIColor whiteColor]];
        [_mainView.layer setMasksToBounds:YES];
        [_mainView.layer setCornerRadius:10.f];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainView;
}
- (UIButton *)confirmButton
{
    if(!_confirmButton) {
        _confirmButton = [[UIButton alloc]init];
        [_confirmButton setBackgroundColor:SRGBCOLOR_HEX(0x6075FB)];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
- (UIButton *)cancelButton
{
    if(!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        [_cancelButton setBackgroundColor:SRGBCOLOR_HEX(0XEBECED)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:SRGBCOLOR_HEX(0X3d3d3d) forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)closedButton
{
    if(!_closedButton) {
        _closedButton = [[UIButton alloc]init];
        [_closedButton setImage:[UIImage imageNamed:@"closed.png"] forState:UIControlStateNormal];
        [_closedButton addTarget:self action:@selector(closedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        _closedButton.hidden = YES;
    }
    return _closedButton;
}

- (UILabel*)headerTitleLabel
{
    if (!_headerTitleLabel) {
        _headerTitleLabel = [[UILabel alloc]init];
        [_headerTitleLabel setFont:[UIFont systemFontOfSize:18.f]];
        [_headerTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [_headerTitleLabel setTextColor:SRGBCOLOR_HEX(0X666666)];
    }
    return _headerTitleLabel;
}

- (UILabel*)contentTextLabel
{
    if (!_contentTextLabel) {
        _contentTextLabel = [[UILabel alloc]init];
        [_contentTextLabel setFont:[UIFont systemFontOfSize:12.f]];
        [_contentTextLabel setTextAlignment:NSTextAlignmentCenter];
        [_contentTextLabel setTextColor:SRGBCOLOR_HEX(0X666666)];
        _contentTextLabel.numberOfLines = 0;
    }
    return _contentTextLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
