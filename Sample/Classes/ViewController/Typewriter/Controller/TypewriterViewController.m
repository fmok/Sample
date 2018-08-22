//
//  TypewriterViewController.m
//  Sample
//
//  Created by wjy on 2018/8/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "TypewriterViewController.h"
#import "TypewriterControl.h"
#import "UIImage+Resize.h"

@interface TypewriterViewController ()
{
    CADisplayLink *link;
}

@property (nonatomic, strong) TypewriterControl *control;
@property (nonatomic, strong) UILabel *typeWriterLab;

@end

@implementation TypewriterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self configureTimer];
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

- (void)configureUI
{
    [self.view addSubview:self.typeWriterLab];
    [self.typeWriterLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)configureTimer
{
    link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkStepHandler)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - Timer
- (void)linkStepHandler
{
    
}

#pragma mark - getter
- (UILabel *)typeWriterLab
{
    if (!_typeWriterLab) {
        _typeWriterLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeWriterLab.font = [UIFont systemFontOfSize:20.f];
        _typeWriterLab.textColor = [UIColor redColor];
        _typeWriterLab.backgroundColor = [UIColor yellowColor];
    }
    return _typeWriterLab;
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
