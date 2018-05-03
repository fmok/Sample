//
//  RecordTool.m
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#define RecordFielName @"Record.caf"

#import "RecordTool.h"

@interface RecordTool () <AVAudioRecorderDelegate>

@property (nonatomic, strong) NSURL *recordFileUrl;  // 录音文件地址
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVAudioSession *session;

@end

@implementation RecordTool

+ (instancetype)sharedRecordTool
{
    static RecordTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[RecordTool alloc] init];
    });
    return tool;
}


#pragma mark - Public methods
- (void)startRecording
{
    // 录音时停止播放 删除曾经生成的文件
    [self stopPlaying];
    [self destructionRecordingFile];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil) {
        TTDPRINT(@"Error creating session: %@", [sessionError description]);
    } else {
        [session setActive:YES error:nil];
    }
    
    self.session = session;
    
    [self.recorder record];

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    self.timer = timer;
}

- (void)stopRecording:(void(^)(BOOL isComplete))block
{
    if ([self.recorder isRecording]) {
        [self.recorder stop];
        [self.timer invalidate];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordToolDidEndRecord:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate recordToolDidEndRecord:self];
        });
    }
    if (block) {
        block(YES);
    }
}

- (void)playRecordingFile
{
    // 播放时停止录音
    [self.recorder stop];
    
    // 正在播放就返回
    if ([self.player isPlaying]) return;

    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:NULL];
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
}

- (void)stopPlaying
{
    [self.player stop];
}

- (void)destructionRecordingFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (self.recordFileUrl) {
        [fileManager removeItemAtURL:self.recordFileUrl error:NULL];
    }
}

#pragma mark -
- (void)updateImage
{
    [self.recorder updateMeters];
    double lowPassResults = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
    CGFloat result  = 10 * (CGFloat)lowPassResults;
    TTDPRINT(@"%f", result);
    NSInteger no = 0;
    if (result > 0 && result <= 1.3) {
        no = 1;
    } else if (result > 1.3 && result <= 2) {
        no = 2;
    } else if (result > 2 && result <= 3.0) {
        no = 3;
    } else if (result > 3.0 && result <= 3.0) {
        no = 4;
    } else if (result > 5.0 && result <= 10) {
        no = 5;
    } else if (result > 10 && result <= 40) {
        no = 6;
    } else if (result > 40) {
        no = 7;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordTool:didstartRecoring:)]) {
        [self.delegate recordTool:self didstartRecoring:no];
    }
}
#pragma mark - getter & setter
- (AVAudioRecorder *)recorder
{
    if (!_recorder) {
        
        // 1.获取沙盒地址
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:RecordFielName];
        self.recordFileUrl = [NSURL fileURLWithPath:filePath];
        TTDPRINT(@"%@", filePath);
        
        // 3.设置录音的一些参数
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        // 音频格式
        setting[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
        // 录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
        setting[AVSampleRateKey] = @(44100);
        // 音频通道数 1 或 2
        setting[AVNumberOfChannelsKey] = @(1);
        // 线性音频的位深度  8、16、24、32
        setting[AVLinearPCMBitDepthKey] = @(8);
        //录音的质量
        setting[AVEncoderAudioQualityKey] = [NSNumber numberWithInt:AVAudioQualityHigh];
        
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:setting error:NULL];
        _recorder.delegate = self;
        _recorder.meteringEnabled = YES;
        
        [_recorder prepareToRecord];
    }
    return _recorder;
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (flag) {
        [self.session setActive:NO error:nil];
    }
}
@end
