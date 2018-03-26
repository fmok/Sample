//
//  FMTabBarViewController.m
//  Sample
//
//  Created by wjy on 2018/3/25.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMTabBarViewController.h"
#import "MainViewController.h"
#import "UIImage+Resize.h"

@interface FMTabBarViewController ()

@property (nonatomic, assign) BOOL statusBarHidden;

@end

@implementation FMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UITabBar appearance].translucent = NO;
    self.zl_navigationBarHidden = YES;
    [self setUp];
}

#pragma mark - Set Up
- (void)setUp
{
    [self setViewControllers:[self viewControllersForTab]];
    [self updateTabBarItemForViewControllers];
}

#pragma mark - Private methods
- (void)updateTabBarItemForViewControllers
{
    for (NSInteger i = 0; i < self.viewControllers.count; i++) {
        UIViewController *viewController = self.viewControllers[i];
        
        UIImage *image = [self imageForState:UIControlStateNormal atIndex:i];
        UIImage *selectedImage = [self imageForState:UIControlStateSelected atIndex:i];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:image selectedImage:selectedImage];
        tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        viewController.tabBarItem = tabBarItem;
    }
    [self.tabBar setTintColor:SRGBCOLOR_HEX(0xf12b35)];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
}

#pragma mark - 处理statusBar
//- (void)setNeedsStatusBarAppearanceUpdateToHide:(BOOL)hidden {
//    self.statusBarHidden = hidden;
//    [self setNeedsStatusBarAppearanceUpdate];
//}

//- (BOOL)prefersStatusBarHidden {
//    return self.statusBarHidden;
//}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;  // UIStatusBarStyleLightContent
//}

#pragma mark - getter & setter
- (NSArray *)viewControllersForTab
{
    return @[
             [[MainViewController alloc] init],
             [[UIViewController alloc] init]
             ];
}

- (UIImage *)imageForState:(UIControlState)state atIndex:(NSInteger)index
{
    NSArray *imageArr = [self imageNamesForState:state];
    if (imageArr.count <= index) {
        return nil;
    } else {
        NSString *imageName = [imageArr objectAtIndex:index];
        return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

- (NSArray *)imageNamesForState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
        {
            return @[@"tabbar_home",
                     @"tabbar_me"];
        }
            break;
        case UIControlStateSelected:
        {
            return @[@"tabbar_home_selected",
                     @"tabbar_me_selected"];
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
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
