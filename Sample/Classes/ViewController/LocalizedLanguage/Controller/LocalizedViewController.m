//
//  LocalizedViewController.m
//  Sample
//
//  Created by wjy on 2018/4/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "LocalizedViewController.h"
#import "UIImage+Resize.h"
#import "LocalizedControl.h"

@interface LocalizedViewController ()

@property (nonatomic, strong) LocalizedControl *contrl;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation LocalizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self.view addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavBarAndStateHeight+80.f);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20.f, 40.f));
    }];
    [self configUI];
    self.textLabel.text = [[LocalizedLanguageManager shareManager] getShowValueWithLocalizedStrKey:@"LocalizedLanguage_testTextStr" andLanTable:@"Localized"];
}

#pragma mark - Public methods
- (void)updateTestLabel:(NSString *)str
{
    self.textLabel.text = str;
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
    static NSInteger const localizedBtnCount = 3;
    for (NSInteger i = 0; i < localizedBtnCount; i++) {
        @autoreleasepool {
            CGFloat W_btn = (kScreenWidth-40.f);
            CGFloat H_btn = (40.f);
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20.f, kNavBarAndStateHeight+200+i*(H_btn+20.f), W_btn, H_btn)];
            btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
            btn.tag = 100+i;
            [btn setTitle:[self changeBtnText][i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:20.f];
            /***/
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            [btn addTarget:self.contrl action:@selector(changeLanguage:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
            [self.view addSubview:btn];
        }
    }
}

#pragma mark - getter & setter
- (LocalizedControl *)contrl
{
    if (!_contrl) {
        _contrl = [[LocalizedControl alloc] init];
        _contrl.vc = self;
    }
    return _contrl;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:20.f];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (NSArray *)changeBtnText
{
    return @[@"简体中文", @"繁體中文", @"English"];
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
