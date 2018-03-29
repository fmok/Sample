//
//  BuyDetailViewController.h
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "BuyDetailCardView.h"
#import "BuyDetailCardSendWordView.h"

@interface BuyDetailViewController : FMBaseViewController

@property (nonatomic, strong) BuyDetailCardView *cardView;
@property (nonatomic, strong) BuyDetailCardSendWordView *cardSendWordView;

@end
