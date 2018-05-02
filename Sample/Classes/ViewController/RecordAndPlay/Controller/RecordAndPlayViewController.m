//
//  RecordAndPlayViewController.m
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "RecordAndPlayViewController.h"
#import "RecordAndPlayControl.h"
#import "UIImage+Resize.h"

@interface RecordAndPlayViewController ()

@property (nonatomic, strong) RecordAndPlayControl *control;

@end

@implementation RecordAndPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self configUI];
    [self.control registerCell];
    [self.control testLoadData];
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

- (void)configUI
{
    [self.view addSubview:self.recordView];
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(self.view);
        CGFloat height = 60.f;
        if (IS_IPHONEX) {
            height += 44.f;
        }
        make.height.mas_equalTo(height);
    }];
    [self.view addSubview:self.recordListView];
    [self.recordListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(kNavBarHeight);
        } else {
            make.top.equalTo(self.mas_topLayoutGuide).offset(kNavBarHeight);
        }
        make.bottom.equalTo(self.recordView.mas_top);
    }];
}

#pragma mark - getter & setter
- (RecordAndPlayControl *)control
{
    if (!_control) {
        _control = [[RecordAndPlayControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (RecordView *)recordView
{
    if (!_recordView) {
        _recordView = [[RecordView alloc] initWithFrame:CGRectZero];
    }
    return _recordView;
}

- (PulledTableView *)recordListView
{
    if (!_recordListView) {
        _recordListView = [[PulledTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _recordListView.backgroundColor = SRGBCOLOR_HEX(0xf6f6f6);
        _recordListView.isHeader = NO;
        _recordListView.isFooter = NO;
        _recordListView.delegate = self.control;
        _recordListView.dataSource = self.control;
    }
    return _recordListView;
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
