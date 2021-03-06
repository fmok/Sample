//
//  PetDetailFeedButton.h
//  Sample
//
//  Created by wjy on 2018/4/19.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const W_H_FeedButton = 100.f;

typedef void(^callBack)(BOOL isFinished);

@interface PetDetailFeedButton : UIButton

- (void)feedButtonShakeAnimation:(void(^)(BOOL isFinished))callBack;

@end
