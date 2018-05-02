//
//  RecordMicView.h
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordMicView : UIView

- (void)showRecordMic;
- (void)removeRecordMic;

- (void)initMicFirstImage;
- (void)setMicImageWithIndex:(NSInteger)idx;

@end
