//
//  FMH5ViewController_wk.m
//  Sample
//
//  Created by wjy on 2018/4/16.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMH5ViewController_wk.h"
#import "UIImage+Resize.h"

@interface FMH5ViewController_wk ()

@end

@implementation FMH5ViewController_wk

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor grayColor];
    [self setUpNav];
}

#pragma mark - Private methods
- (void)setUpNav
{
    [self configNavBarBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.zl_navigationBar.tintColor = [UIColor blackColor];
    self.zl_navigationBar.titleTextAttributes = @{
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f],
                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                  };
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
