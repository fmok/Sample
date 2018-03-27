//
//  MeViewController.h
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "PulledTableView.h"
#import "MeHeaderView.h"

@interface MeViewController : FMBaseViewController

@property (nonatomic, strong) PulledTableView *mePulledTableView;
@property (nonatomic, strong) MeHeaderView *headerView;

@end
