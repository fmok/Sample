//
//  PetDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailViewController.h"
#import "PetDetailControl.h"

@interface PetDetailViewController ()

@property (nonatomic, strong) PetDetailControl *control;

@end

@implementation PetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - getter & setter
- (PetDetailControl *)control
{
    if (!_control) {
        _control = [[PetDetailControl alloc] init];
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
