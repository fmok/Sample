//
//  RecordView.m
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "RecordView.h"
#import "RecordTool.h"
#import "HUD.h"
#import "RecordMicView.h"

static NSString *const recordTipStr_pressStart = @"按住 开始";
static NSString *const recordTipStr_loosenEnd = @"松开 结束";
static NSString *const recordTipStr_loosenCancel = @"松开 取消";

@interface RecordView ()<
    RecordToolDelegate>

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) RecordTool *recordTool;
@property (nonatomic, strong) RecordMicView *micView;

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

#pragma mark - Events
- (void)recordBtnDidTouchDown:(UIButton *)recordBtn
{
    [self.recordTool startRecording];
    [self.micView showRecordMic];
    recordBtn.highlighted = YES;
    recordBtn.backgroundColor = SRGBCOLOR_HEX(0xf6f6f6);
}

- (void)recordBtnDidTouchUpInside:(UIButton *)recordBtn
{
    recordBtn.highlighted = NO;
    recordBtn.backgroundColor = SRGBCOLOR_HEX(0xffffff);
    double currentTime = self.recordTool.recorder.currentTime;
    NSLog(@"%lf", currentTime);
    if (currentTime < 2) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self.recordTool stopRecording:^(BOOL isComplete) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [HUD showTipWithText:@"说话时间太短"];
                });
            }];
            [self.recordTool destructionRecordingFile];
        });
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.recordTool stopRecording:nil];
        });
        TTDPRINT(@"已成功录音");
    }
}

- (void)recordBtnDidTouchDragEnter:(UIButton *)recordBtn
{
    recordBtn.highlighted = YES;
    [self.recordButton setTitle:recordTipStr_loosenEnd forState:UIControlStateHighlighted];
    [self.micView hiddenCancelLogo];
}

- (void)recordBtnDidTouchDragExit:(UIButton *)recordBtn
{
    recordBtn.highlighted = NO;
    [self.recordButton setTitle:recordTipStr_loosenCancel forState:UIControlStateNormal];
    [self.micView showCancelLogo];
}

- (void)recordingBtnDidTouchUpOutSide:(UIButton *)recordBtn
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.recordTool stopRecording:nil];
        [self.recordTool destructionRecordingFile];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            recordBtn.backgroundColor = SRGBCOLOR_HEX(0xffffff);
            recordBtn.highlighted = NO;
            [self.recordButton setTitle:recordTipStr_pressStart forState:UIControlStateNormal];
        });
    });
}

#pragma mark - RecordToolDelegate
- (void)recordTool:(RecordTool *)recordTool didstartRecoring:(NSInteger)no
{
    [self.micView setMicImageWithIndex:no];
}

- (void)recordToolDidEndRecord:(RecordTool *)recordTool
{
    [self.micView removeRecordMic];
    TTDPRINT(@"record did stop");
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
        [_recordButton setTitle:recordTipStr_pressStart forState:UIControlStateNormal];
        [_recordButton setTitle:recordTipStr_loosenEnd forState:UIControlStateHighlighted];
        [_recordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _recordButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
        [_recordButton addTarget:self action:@selector(recordBtnDidTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_recordButton addTarget:self action:@selector(recordBtnDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_recordButton addTarget:self action:@selector(recordBtnDidTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [_recordButton addTarget:self action:@selector(recordBtnDidTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [_recordButton addTarget:self action:@selector(recordingBtnDidTouchUpOutSide:) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _recordButton;
}

- (RecordTool *)recordTool
{
    if (!_recordTool) {
        _recordTool = [RecordTool sharedRecordTool];
        _recordTool.delegate = self;
    }
    return _recordTool;
}

- (RecordMicView *)micView
{
    if (!_micView) {
        _micView = [[RecordMicView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _micView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
