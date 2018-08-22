//
//  SampleViewController.m
//  Sample
//
//  Created by wjy on 2018/7/12.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "SampleViewController.h"
#import "SampleControl.h"

@interface SampleViewController ()

@property (nonatomic, strong) SampleControl *control;

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - getter & setter
- (SampleControl *)control
{
    if (!_control) {
        _control = [[SampleControl alloc] init];
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
