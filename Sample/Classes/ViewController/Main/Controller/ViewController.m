//
//  ViewController.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "ViewController.h"
#import "Control.h"

@interface ViewController ()

@property (nonatomic, strong) Control *control;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)dealloc
{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tmpImgView];
    WS(weakSelf);
    [self.tmpImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(100.f);
        make.leading.mas_equalTo(weakSelf.view).offset(20.f);
        make.size.mas_equalTo(CGSizeMake(100.f, 100.f));
    }];
}

#pragma mark - Override methods
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.control testRequest];
}

#pragma mark - Private methods


#pragma mark - getter & setter
- (Control *)control
{
    if (!_control) {
        _control = [[Control alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (NSMutableArray *)cardInfoArr
{
    if (!_cardInfoArr) {
        _cardInfoArr = [[NSMutableArray alloc] init];
    }
    return _cardInfoArr;
}

- (UIImageView *)tmpImgView
{
    if (!_tmpImgView) {
        _tmpImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _tmpImgView.backgroundColor = [UIColor yellowColor];
        _tmpImgView.contentMode = UIViewContentModeScaleAspectFill;
        _tmpImgView.clipsToBounds = YES;
    }
    return _tmpImgView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
