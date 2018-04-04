//
//  PetDetailControl.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailControl.h"

@interface PetDetailControl ()

@end

@implementation PetDetailControl

#pragma mark - Public methods
- (void)loadData
{
    [self serializeData];
}

#pragma mark - Private nethods
- (void)serializeData
{
    [self updateTopTabView:self.vc.currentIndexForCardScrollView];
    [self.vc.petScrollView updateContent];
    [self.vc.petScrollView setInitailIndexCard:self.vc.currentIndexForCardScrollView];
}

- (void)updateTopTabView:(NSInteger)idx
{
    self.vc.topTabView.items = @[[NSString stringWithFormat:@"成长：%@", @(((arc4random()%10) + 1))],
                                 [NSString stringWithFormat:@"智慧：%@", @(((arc4random()%10) + 1))],
                                 [NSString stringWithFormat:@"生育：%@", @(((arc4random()%10) + 1))],
                                 [NSString stringWithFormat:@"魅力：%@", @(((arc4random()%10) + 1))]];
}

#pragma mark - FMCardsStackScrollViewDelegate
- (void)cardScrollToIndex:(NSInteger)idx
{
    self.vc.currentIndexForCardScrollView = idx;
    [self updateTopTabView:idx];
}

@end
