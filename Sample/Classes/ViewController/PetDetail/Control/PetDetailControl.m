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
    self.vc.topTabView.items = @[[NSString stringWithFormat:@"成长：%@", @(((arc4random()%10) + 1))],
                                 [NSString stringWithFormat:@"智慧：%@", @(((arc4random()%10) + 1))],
                                 [NSString stringWithFormat:@"生育：%@", @(((arc4random()%10) + 1))],
                                 [NSString stringWithFormat:@"魅力：%@", @(((arc4random()%10) + 1))]];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.vc.topTabView.items = @[[NSString stringWithFormat:@"成长：%@", @(((arc4random()%10) + 1))],
                                     [NSString stringWithFormat:@"智慧：%@", @(((arc4random()%10) + 1))],
                                     [NSString stringWithFormat:@"生育：%@", @(((arc4random()%10) + 1))],
                                     [NSString stringWithFormat:@"魅力：%@", @(((arc4random()%10) + 1))]];
    });
    [self.vc.petScrollView updateContent];
}

@end
