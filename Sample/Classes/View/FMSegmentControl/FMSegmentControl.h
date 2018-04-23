//
//  FMSegmentControl.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kSegmentControlTitleColorNormal = @"titleColorNormal";
static NSString *const kSegmentControlTitleColorSelected = @"titleColorSelected";
static NSString *const kSegmentControlTitleFont = @"titleFont";

static NSString *const kSegmentControlSegBgColorNormal = @"segBgColorNormal";
static NSString *const kSegmentControlSegBgColorSelected = @"segBgColorSelected";

static NSString *const kSegmentControlBorderColor = @"borderColor";
static NSString *const kSegmentControlCornerRadius = @"cornerRadius";
static NSString *const kSegmentControlBorderWidth = @"borderWidth";

@class FMSegmentControl;

@protocol FMSegmentControlDelegate<NSObject>

- (void)segmentedControl:(FMSegmentControl *)segment didSeletedItemAtIndex:(NSInteger)index;

@end

@interface FMSegmentControl : UIControl

@property (nonatomic, weak) id<FMSegmentControlDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *configureDic;

void configureDic(UIColor *titleColorNormal, UIColor *titleColorSelected, UIFont *titleFont, UIColor *segBgColorNormal, UIColor *segBgColorSelected, UIColor *borderColor, CGFloat cornerRadius, CGFloat borderWidth);

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items configureDic:(NSDictionary *)configureDic currentIndex:(NSInteger)currentIndex;

- (void)scrollToIndex:(NSInteger)index;
- (void)scrollByProgress:(CGFloat)progress;  // 0.0 - index.progress  if you want to scroll to index 2, set progress 0.0 - 2.0;

@end
