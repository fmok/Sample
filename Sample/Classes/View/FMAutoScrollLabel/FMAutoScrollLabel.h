//
//  FMAutoScrollLabel.h
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AutoScrollDirection) {
    AutoScrollDirectionRight,
    AutoScrollDirectionLeft,
};

@interface FMAutoScrollLabel : UIScrollView

@property(nonatomic) enum AutoScrollDirection scrollDirection;
@property(nonatomic) float scrollSpeed;
@property(nonatomic) NSTimeInterval pauseInterval;
@property(nonatomic) CGFloat bufferSpaceBetweenLabels;
// normal UILabel properties
@property(nonatomic,retain) UIColor *textColor;
@property(nonatomic, retain) UIFont *font;

- (void)readjustLabels;
- (void)setText: (NSString *) text;
- (NSString *)text;
- (void)scroll;
- (void)removeAnimations;

@end
