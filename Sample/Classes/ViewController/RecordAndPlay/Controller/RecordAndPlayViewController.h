//
//  RecordAndPlayViewController.h
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "RecordView.h"
#import "PulledTableView.h"

@interface RecordAndPlayViewController : FMBaseViewController

@property (nonatomic, strong) RecordView *recordView;
@property (nonatomic, strong) PulledTableView *recordListView;

@end
