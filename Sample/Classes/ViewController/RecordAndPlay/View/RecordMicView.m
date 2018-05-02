//
//  RecordMicView.m
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "RecordMicView.h"

@interface RecordMicView ()

@property (nonatomic, strong) UIImageView *micImageView;

@end

@implementation RecordMicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        self.layer.cornerRadius = 5.f;
        self.clipsToBounds = YES;
        [self addSubview:self.micImageView];
        [self.micImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(frame.size.width-20.f, frame.size.height-20.f));
        }];
    }
    return self;
}

#pragma mark - Public methods
- (void)showRecordMic
{
    UIWindow *keyboardWindow = [[[UIApplication sharedApplication] windows] lastObject];
    self.center = keyboardWindow.center;
    [keyboardWindow addSubview:self];
}

- (void)removeRecordMic
{
    [self removeFromSuperview];
}

- (void)initMicFirstImage
{
    self.micImageView.image = [UIImage imageNamed:@"mic_0"];
}

- (void)setMicImageWithIndex:(NSInteger)idx
{
    NSString *imageName = [NSString stringWithFormat:@"mic_%@", @(idx)];
    self.micImageView.image = [UIImage imageNamed:imageName];
}

#pragma mark - getter & setter
- (UIImageView *)micImageView
{
    if (!_micImageView) {
        _micImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _micImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
