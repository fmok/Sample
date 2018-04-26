//
// Created by 周东兴 on 2017/4/7.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import "FTHShareComponentDefines.h"

@interface FTHShareComponentEditView : UIView

@property (nonatomic, copy) FTHShareComponentEditViewContext context;

- (void)setDefaultText:(NSString *)text;

- (void)beginEdit;
- (void)endEdit;
@end