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
    [self serializeData];
}

#pragma mark - Private nethods
- (void)serializeData
{
    [self.vc updatePetTabs:@[@"成长：1", @"智慧：1.5", @"生育：2", @"魅力：1.5"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.vc updatePetTabs:@[@"成长：2", @"智慧：3", @"生育：4", @"魅力：3"]];
    });
}

@end
