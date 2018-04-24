//
//  FMSegmentControl.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMSegmentControl;

typedef void(^FMSegmentControlConfigBlock)(BOOL isNeed);

@protocol FMSegmentControlDelegate<NSObject>

- (void)segmentedControl:(FMSegmentControl *)segment didSeletedItemAtIndex:(NSInteger)index;

@end

@interface FMSegmentControl : UIControl

@property (nonatomic, weak) id<FMSegmentControlDelegate> delegate;

void configureDic(UIColor *titleColorNormal, UIColor *titleColorSelected, UIFont *titleFont, UIColor *segBgColorNormal, UIColor *segBgColorSelected, UIColor *borderColor, CGFloat cornerRadius, CGFloat borderWidth);

/**
 在 configureBlock 中，可以调用上述C函数，添加相关属性的默认配置；block 传nil，则为默认配置
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items currentIndex:(NSInteger)currentIndex configureBlock:(FMSegmentControlConfigBlock)block;

- (void)scrollToIndex:(NSInteger)index;
- (void)scrollByProgress:(CGFloat)progress;  // 0.0 - index.progress  if you want to scroll to index 2, set progress 0.0 - 2.0;

@end
