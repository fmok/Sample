//
//  ZLNavigationBar.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "ZLNavigationBar.h"

@interface ZLNavigationBar() <UINavigationBarDelegate>
@end

@implementation ZLNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.translucent = NO;
    }
    return self;
}

- (UIBarPosition)barPosition {
    return UIBarPositionTopAttached;
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (CGSize)intrinsicContentSize {
    if (@available(iOS 11.0, *)) {
        if (self.prefersLargeTitles) {
            UIFont *largeTitleFont = self.largeTitleTextAttributes[NSFontAttributeName];
            if (largeTitleFont) {
                return CGSizeMake(0, 44 + round(largeTitleFont.lineHeight));
            }
            return CGSizeMake(0, 96);
        }
    }
    return CGSizeMake(0, 44);
}


@end
