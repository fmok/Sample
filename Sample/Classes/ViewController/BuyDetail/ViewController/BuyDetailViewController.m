//
//  BuyDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "BuyDetailViewController.h"
#import "BuyDetailControl.h"

@interface BuyDetailViewController ()

@property (nonatomic, strong) BuyDetailControl *control;

@end

@implementation BuyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self configNavBarOpaque:YES];
}


#pragma mark - getter & setter
- (BuyDetailControl *)control
{
    if (!_control) {
        _control = [[BuyDetailControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
