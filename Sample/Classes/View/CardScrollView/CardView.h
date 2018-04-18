//
//  CardView.h
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Gap_CardViewEdges 15.5f
#define W_CardView (kScreenWidth-Gap_CardViewEdges*2)
#define H_CardView ((265.5f/345.f)*W_CardView)

@interface CardView : UIView

- (void)updateContent:(NSString *)imgUrl;

@end
