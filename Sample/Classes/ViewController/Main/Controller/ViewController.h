//
//  ViewController.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PulledTableView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *cardInfoArr;
@property (nonatomic, strong) PulledTableView *pulledTableView;

@end

