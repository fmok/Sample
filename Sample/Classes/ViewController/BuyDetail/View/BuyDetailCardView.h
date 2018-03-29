//
//  BuyDetailCardView.h
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const gap_left_right_buyDetail = 14.5f;
#define W_Card (kScreenWidth-2*gap_left_right_buyDetail)
#define H_Card ((kScreenWidth-2*gap_left_right_buyDetail)*(265.5f/345.f))

@interface BuyDetailCardView : UIView

- (void)updateContentWithCardImgUrl:(NSString *)imgUrl cost:(NSString *)cost;

@end
