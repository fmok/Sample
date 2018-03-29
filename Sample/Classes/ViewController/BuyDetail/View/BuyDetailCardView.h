//
//  BuyDetailCardView.h
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define W_Card (kScreenWidth-2*gap_left_right_buyDetail)
#define H_Card (W_Card*(265.5f/345.f))

@interface BuyDetailCardView : UIView

- (void)updateContentWithCardImgUrl:(NSString *)imgUrl cost:(NSString *)cost;

@end
