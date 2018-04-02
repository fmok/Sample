//
//  PetDetailTopTabView.h
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const PetDetailTopTab_growUp = @"成长";
static NSString *const PetDetailTopTab_wisdom = @"智慧";
static NSString *const PetDetailTopTab_giveBirth = @"生育";
static NSString *const PetDetailTopTab_charm = @"魅力";

#define H_TopTabView_PetDetail 49.f

@interface PetDetailTopTabView : UIView

@property (nonatomic, strong) NSArray *items;

@end
