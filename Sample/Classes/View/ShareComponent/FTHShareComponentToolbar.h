//
// Created by 周东兴 on 2017/3/8.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import "FTHShareComponentDefines.h"

@interface FTHShareComponentToolbar : UIView

@property (nonatomic, copy) FTHShareComponentViewContext  shareViewContext;

- (instancetype)initWithItems:(NSArray *)items;

- (void)startAnimation;
@end
