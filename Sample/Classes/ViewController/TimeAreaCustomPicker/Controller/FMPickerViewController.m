//
//  FMPickerViewController.m
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMPickerViewController.h"
#import "FMPickerControl.h"
#import "UIImage+Resize.h"

@interface FMPickerViewController ()

@property (nonatomic, strong) FMPickerControl *control;

@end

@implementation FMPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self configUI];
}

#pragma mark - Private
- (void)setUpNav
{
    [self configNavBarBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.fm_navigationBar.tintColor = [UIColor blackColor];
    self.fm_navigationBar.titleTextAttributes = @{
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f],
                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                  };
}

- (void)configUI
{
    WS(weakSelf);
    [self.view addSubview:self.textArea];
    [self.view addSubview:self.textSingle];
    [self.view addSubview:self.textDate];
    [self.textArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(100.f);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width*0.6, 30.f));
    }];
    [self.textSingle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.textArea.mas_bottom).offset(50.f);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width*0.6, 30.f));
    }];
    [self.textDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.textSingle.mas_bottom).offset(50.f);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width*0.6, 30.f));
    }];
}

#pragma mark - getter & setter
- (FMPickerControl *)control
{
    if (!_control) {
        _control = [[FMPickerControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (UITextField *)textArea
{
    if (!_textArea) {
        _textArea = [[UITextField alloc] initWithFrame:CGRectZero];
        _textArea.borderStyle = UITextBorderStyleRoundedRect;
        _textArea.placeholder = @"地区";
        _textArea.delegate = self.control;
    }
    return _textArea;
}

- (UITextField *)textSingle
{
    if (!_textSingle) {
        _textSingle = [[UITextField alloc] initWithFrame:CGRectZero];
        _textSingle.borderStyle = UITextBorderStyleRoundedRect;
        _textSingle.placeholder = @"🙄";
        _textSingle.delegate = self.control;
    }
    return _textSingle;
}

- (UITextField *)textDate
{
    if (!_textDate) {
        _textDate = [[UITextField alloc] initWithFrame:CGRectZero];
        _textDate.borderStyle = UITextBorderStyleRoundedRect;
        _textDate.placeholder = @"日期";
        _textDate.delegate = self.control;
    }
    return _textDate;
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
