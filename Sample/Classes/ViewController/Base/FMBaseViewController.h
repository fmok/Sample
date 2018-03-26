//
//  FMBaseViewController.h
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMBaseViewController : UIViewController

@property (nonatomic, weak) UINavigationController *nav;

- (void)showHUDTip:(NSString *)string;

@end
