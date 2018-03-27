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
    self.view.backgroundColor = [UIColor whiteColor];
    self.zl_automaticallyAdjustsScrollViewInsets = YES;
    [self setNavInitialSetup];
}

#pragma mark - Private methods
/**
 导航初始设置
 */
- (void)setNavInitialSetup
{
    // 返回按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.zl_navigationItem.leftBarButtonItems = @[backBtn];
    // 线条颜色
    self.zl_navigationBar.tintColor = [UIColor whiteColor];
    // 透明度
    [self.zl_navigationBar setValue:@(0)forKeyPath:@"backgroundView.alpha"];
    // 文字样式
    self.zl_navigationBar.titleTextAttributes = @{
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f],
                                                  NSForegroundColorAttributeName: [UIColor whiteColor]
                                                  };
}

#pragma mark - Public methods
- (void)showHUDTip:(NSString *)string
{
    [HUD showTipOfView:self.view text:string];
}

- (void)constraintNavigationBar:(UINavigationBar *)navigationBar
{
    navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraint;
    if (@available(iOS 11.0, *)) {
        UILayoutGuide *safeAreaLayoutGuide = self.view.safeAreaLayoutGuide;
        NSLayoutConstraint *a = [navigationBar.leadingAnchor constraintEqualToAnchor:safeAreaLayoutGuide.leadingAnchor];
        NSLayoutConstraint *b = [navigationBar.trailingAnchor constraintEqualToAnchor:safeAreaLayoutGuide.trailingAnchor constant:0];
        NSLayoutConstraint *c = [navigationBar.topAnchor constraintEqualToAnchor:safeAreaLayoutGuide.topAnchor constant:0];
        constraint = @[a, b, c];
    } else {
        NSLayoutConstraint *a = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *b = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        CGFloat constant = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        
        NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
        constraint = @[a, b, c];
    }
    [NSLayoutConstraint activateConstraints:constraint];
}

#pragma mark - Events
- (void)popVC
{
    [self.zl_navigationController popViewControllerAnimated:YES];
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
