//
//  FMSegmentControl.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMSegmentControl;

@protocol FMSegmentControlDelegate<NSObject>

- (void)segmentedControl:(FMSegmentControl *)segment didSeletedItemAtIndex:(NSInteger)index;

@end

@interface FMSegmentControl : UIControl

@property (nonatomic, weak) id<FMSegmentControlDelegate> delegate;
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithItems:(NSArray *)items;
- (void)commitInitWithTitleNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor font:(UIFont *)font;
- (void)commitInitWithSegBgColorNormal:(UIColor *)segBgNormal segBgColorSelected:(UIColor *)segBgSelected;
- (void)commitInitWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

- (void)scrollToIndex:(NSInteger)index;
- (void)scrollByProgress:(CGFloat)progress;  // 0.0 - index.progress  if you want to scroll to index 2, set progress 0.0 - 2.0;

@end
