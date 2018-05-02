//
//  RecordView.m
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "RecordView.h"

@interface RecordView ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIButton *recordButton;

@end

@implementation RecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SRGBCOLOR_HEX(0xffffff);
        [self addSubview:self.topLine];
        [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(self);
            make.height.mas_equalTo(1.f);
        }];
        CGFloat gap = 10.f;
        [self addSubview:self.recordButton];
        [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(gap);
            make.right.equalTo(self).offset(-gap);
            make.top.equalTo(self).offset(gap);
            CGFloat bottomGap = gap;
            if (IS_IPHONEX) {
                bottomGap += 44.f;
            }
            make.bottom.equalTo(self).offset(-bottomGap);
        }];
    }
    return self;
}

#pragma mark - getter & seter
- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = SRGBCOLOR_HEX(0xe5e5e5);
    }
    return _topLine;
}

- (UIButton *)recordButton
{
    if (!_recordButton) {
        _recordButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _recordButton.layer.cornerRadius = 5.f;
        _recordButton.layer.borderColor = SRGBCOLOR_HEX(0xe5e5e5).CGColor;
        _recordButton.layer.borderWidth = 1.f;
        [_recordButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_recordButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [_recordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _recordButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    }
    return _recordButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
