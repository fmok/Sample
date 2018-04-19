//
//  UITableViewCell+showAnimaiton.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "UITableViewCell+showAnimaiton.h"
#import <objc/runtime.h>

@implementation UITableViewCell (showAnimaiton)

YYSYNTH_DYNAMIC_PROPERTY_CTYPE(isDisplayed, setDisplayed, BOOL)

- (void)tableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath animationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle {
    if (!self.isDisplayed) {
        switch (animationStyle) {
            case UITableViewCellDisplayAnimationTop: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.y = -frame.size.height;
                self.frame = frame;
                
                NSTimeInterval duration = 0.1 + (NSTimeInterval)(indexPath.row) / 15.0;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationLeft: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.x = -frame.size.width;
                self.frame = frame;
                
                NSTimeInterval duration = 0.5 + (NSTimeInterval)(indexPath.row) / 10.0;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationBottom: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.y = tableView.frame.size.height;
                self.frame = frame;
                
                NSTimeInterval duration = 0.5 + (NSTimeInterval)(indexPath.row) / 10.0;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationRight: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.x = tableView.frame.size.width;
                self.frame = frame;
                
                NSTimeInterval duration = 0.5 + (NSTimeInterval)(indexPath.row) / 10.0;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationTopTogether: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.y = -frame.size.height;
                self.frame = frame;
                
                NSTimeInterval duration = 0.5f;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationLeftTogether: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.x = -frame.size.width;
                self.frame = frame;
                
                NSTimeInterval duration = 0.5f;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationBottomTogether: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.y = tableView.frame.size.height;
                self.frame = frame;
                
                NSTimeInterval duration = 0.5;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationRightTogether: {
                CGRect originFrame = self.frame;
                CGRect frame = self.frame;
                frame.origin.x = tableView.frame.size.width;
                self.frame = frame;
                
                NSTimeInterval duration = 0.5f;
                [UIView animateWithDuration:duration animations:^{
                    self.frame = originFrame;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationFadeIn: {
                self.alpha = 0;
                
                NSTimeInterval duration = 0.5 + (NSTimeInterval)(indexPath.row) / 10.0;
                [UIView animateWithDuration:duration animations:^{
                    self.alpha = 1;
                } completion:nil];
                break;
            }
            case UITableViewCellDisplayAnimationFadeInTogether: {
                self.alpha = 0;
                
                NSTimeInterval duration = 0.5;
                [UIView animateWithDuration:duration animations:^{
                    self.alpha = 1;
                } completion:nil];
                break;
            }
        }
        self.displayed = YES;
    }
}

@end
