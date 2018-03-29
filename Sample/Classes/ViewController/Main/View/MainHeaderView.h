//
//  HeaderView.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainHeaderViewDelegate <NSObject>

- (void)siginAction;

@end

@interface MainHeaderView : UIView

@property (nonatomic, weak) id<MainHeaderViewDelegate>delegate;

- (void)updateContent;

@end
