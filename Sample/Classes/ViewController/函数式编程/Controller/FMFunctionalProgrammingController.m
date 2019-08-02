//
//  FMFunctionalProgrammingController.m
//  Sample
//
//  Created by wjy on 2019/8/2.
//  Copyright © 2019 wjy. All rights reserved.
//

#import "FMFunctionalProgrammingController.h"
#import "UIImage+Resize.h"
#import "FMCalulator.h"

@interface FMFunctionalProgrammingController ()

@end

@implementation FMFunctionalProgrammingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    FMCalulator *fcal = [[FMCalulator alloc] init];
    NSInteger result1 = [fcal caculator:^NSInteger(NSInteger result) {
        result += 10;
        result *= 10;
        return result;
    }].result;
    TTDPRINT(@"%@", @(result1));
    NSInteger result2 = [fcal caculator:^NSInteger(NSInteger result) {
        result *= 100;
        return result;
    }].result;
    TTDPRINT(@"%@", @(result2));
}

#pragma mark - Private methods
- (void)setUpNav
{
    [self configNavBarBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.fm_navigationBar.tintColor = [UIColor blackColor];
    self.fm_navigationBar.titleTextAttributes = @{
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f],
                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                  };
    
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
