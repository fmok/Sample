//
//  RecordTool.h
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class RecordTool;
@protocol RecordToolDelegate <NSObject>

@optional
- (void)recordTool:(RecordTool *)recordTool didstartRecoring:(NSInteger)no;
- (void)recordToolDidEndRecord:(RecordTool *)recordTool;

@end

@interface RecordTool : NSObject

+ (instancetype)sharedRecordTool;

/** 开始录音 */
- (void)startRecording;

/** 停止录音 */
- (void)stopRecording:(void(^)(BOOL isComplete))block;

/** 播放录音文件 */
- (void)playRecordingFile;

/** 停止播放录音文件 */
- (void)stopPlaying;

/** 销毁录音文件 */
- (void)destructionRecordingFile;

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, weak) id<RecordToolDelegate>delegate;

@end
