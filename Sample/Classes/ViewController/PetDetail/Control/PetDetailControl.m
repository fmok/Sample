//
//  PetDetailControl.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailControl.h"

@implementation PetDetailControl

#pragma mark - Public methods
- (void)loadData
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self serializeData];
//    });
}

#pragma mark - Private nethods
- (void)serializeData
{
    [self.vc updatePetTabs:@[@"成长：1", @"智慧：1.5", @"生育：2", @"魅力：1.5"]];
}

@end
