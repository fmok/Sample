//
// Created by 周东兴 on 2017/4/7.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import "FTHShareComponentEditView.h"
#import "FTHShareComponentDefines.h"

@interface FTHShareComponentEditView () <FTHShareComponentTransmit,UITextViewDelegate>
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIButton *submit;
@property(nonatomic, strong) UIButton *cancel;
@end

@implementation FTHShareComponentEditView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.layer.borderColor = [UIColor colorWithRed:179.0f / 255
                                                           green:179.0f / 255
                                                            blue:179.0f / 255
                                                           alpha:1].CGColor;
        _containerView.layer.borderWidth = .5f;
        _containerView.layer.cornerRadius = 1.0;

        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:16.f];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.delegate = self;

        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;

        _submit = [[UIButton alloc] init];
        _submit.translatesAutoresizingMaskIntoConstraints = NO;
        _submit.layer.borderColor = [UIColor colorWithRed:179.0f / 255
                                                    green:179.0f / 255
                                                     blue:179.0f / 255
                                                    alpha:1].CGColor;
        _submit.layer.borderWidth = .5f;
        _submit.layer.cornerRadius = 1.0;
        [_submit setTitle:@"发布" forState:UIControlStateNormal];
        [_submit addTarget:self action:@selector(didPressSubmit) forControlEvents:UIControlEventTouchUpInside];

        _cancel = [[UIButton alloc] init];
        _cancel.translatesAutoresizingMaskIntoConstraints = NO;
        _cancel.layer.borderColor = [UIColor colorWithRed:179.0f / 255
                                                    green:179.0f / 255
                                                     blue:179.0f / 255
                                                    alpha:1].CGColor;
        _cancel.layer.borderWidth = .5f;
        _cancel.layer.cornerRadius = 1.0;
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(didPressCancel) forControlEvents:UIControlEventTouchUpInside];

        [_containerView addSubview:_textView];
        [_containerView addSubview:_textLabel];
        [self addSubview:_containerView];
        [self addSubview:_submit];
        [self addSubview:_cancel];
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    if (newSuperview) {
        self.context(self, self.textLabel, self.containerView, self.textView, self.submit, self.cancel);
    }
}

#pragma mark - Public Methods

- (void)setDefaultText:(NSString *)text {
    self.textView.text = text;
}

- (void)beginEdit {
    [self.textView becomeFirstResponder];
}

- (void)endEdit {
    [self endEditing:YES];
}

#pragma mark - Target Methods

- (void)didPressSubmit {
    id <FTHShareComponentTransmit> deliver = (id <FTHShareComponentTransmit>)self.nextResponder.nextResponder;

    NSString *text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    [deliver transmitWeiboEdit:NO text:text];
}

- (void)didPressCancel {
    id <FTHShareComponentTransmit> deliver = (id <FTHShareComponentTransmit>)self.nextResponder.nextResponder;
    [deliver transmitWeiboEdit:YES text:nil];
}

#pragma mark - 

- (void)textViewDidChange:(UITextView *)textView {
    NSUInteger length = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length;

    self.submit.enabled = length > 0 && length <= 120;
}

#pragma mark - Private Methods

#pragma mark - Layout

- (void)updateConstraints {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:12];

    [array addObject:[NSLayoutConstraint constraintWithItem:self.containerView
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:0
                                                 multiplier:1.0
                                                   constant:100]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.containerView
                                                  attribute:NSLayoutAttributeLeft
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                  attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0
                                                   constant:20]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.containerView
                                                  attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                  attribute:NSLayoutAttributeRight
                                                 multiplier:1.0
                                                   constant:-20]];

    [array addObject:[NSLayoutConstraint constraintWithItem:self.containerView
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                  attribute:NSLayoutAttributeTop
                                                 multiplier:1.0
                                                   constant:10]];

    [array addObject:[NSLayoutConstraint constraintWithItem:self.textView
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:0
                                                 multiplier:1.0
                                                   constant:70]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.textView
                                                  attribute:NSLayoutAttributeLeft
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.containerView
                                                  attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0
                                                   constant:0]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.textView
                                                  attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.containerView
                                                  attribute:NSLayoutAttributeRight
                                                 multiplier:1.0
                                                   constant:0]];

    [array addObject:[NSLayoutConstraint constraintWithItem:self.textView
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.containerView
                                                  attribute:NSLayoutAttributeTop
                                                 multiplier:1.0
                                                   constant:0]];

    [array addObject:[NSLayoutConstraint constraintWithItem:self.submit
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.containerView
                                                  attribute:NSLayoutAttributeBottom
                                                 multiplier:1.0
                                                   constant:10]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.submit
                                                  attribute:NSLayoutAttributeLeft
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                  attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0
                                                   constant:20]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.submit
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:0
                                                 multiplier:1.0
                                                   constant:36]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.submit
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                  attribute:NSLayoutAttributeWidth
                                                 multiplier:13.0f / 32
                                                   constant:0]];

    [array addObject:[NSLayoutConstraint constraintWithItem:self.cancel
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.containerView
                                                  attribute:NSLayoutAttributeBottom
                                                 multiplier:1.0
                                                   constant:10]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.cancel
                                                  attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                  attribute:NSLayoutAttributeRight
                                                 multiplier:1.0
                                                   constant:-20]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.cancel
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:0
                                                 multiplier:1.0
                                                   constant:36]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self.cancel
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.submit
                                                  attribute:NSLayoutAttributeWidth
                                                 multiplier:1.0
                                                   constant:0]];

    [NSLayoutConstraint activateConstraints:array];

    [super updateConstraints];
}

#pragma mark -


@end