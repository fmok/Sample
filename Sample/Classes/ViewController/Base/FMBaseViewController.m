//
//  FMBaseViewController.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "HUD.h"

@interface FMBaseViewController ()

@end

@implementation FMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Public methods
- (void)showHUDTip:(NSString *)string
{
    [HUD showTipOfView:self.view text:string];
}

#pragma mark - getter & setter
- (UINavigationController *)nav
{
    return (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
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
