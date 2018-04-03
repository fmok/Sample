//
//  PetDetailTopTabView.h
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PetDetailTopTabViewDelegate <NSObject>

@optional;
- (void)clickTabIndex:(NSInteger)idx;

@end

@interface PetDetailTopTabView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) BOOL isNeedVerticalBar;
@property (nonatomic, weak) id<PetDetailTopTabViewDelegate>delegate;

- (void)updateTabContent:(NSArray *)items;
- (void)initConfigurationBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont verticalBarColor:(UIColor *)verticalBarColor;

@end
