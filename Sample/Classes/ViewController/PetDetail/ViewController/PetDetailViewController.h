//
//  PetDetailViewController.h
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"

#define gap_left_right_PetDetail 15.5f

@interface PetDetailViewController : FMBaseViewController

- (void)updatePetDes:(NSString *)petDes;
- (void)updatePetTabs:(NSArray *)items;

@end
