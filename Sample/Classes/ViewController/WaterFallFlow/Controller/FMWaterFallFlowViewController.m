//
//  FMWaterFallFlowViewController.m
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMWaterFallFlowViewController.h"
#import "FMWaterFallFlowControl.h"
#import "UIImage+Resize.h"

@interface FMWaterFallFlowViewController ()

@property (nonatomic, strong) FMWaterFallFlowControl *control;

@end

@implementation FMWaterFallFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    WS(weakSelf);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.control registerCell];
    [self.control loadData];
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

#pragma mark - getter & setter
- (FMWaterFallFlowControl *)control
{
    if (!_control) {
        _control = [[FMWaterFallFlowControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (PulledCollectionView *)collectionView
{
    if (!_collectionView) {
        LMHWaterFallLayout *flowLayout = [[LMHWaterFallLayout alloc] init];
        flowLayout.delegate = self.control;
        _collectionView = [[PulledCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self.control;
        _collectionView.delegate = self.control;
        _collectionView.pulledDelegate = self.control;
    }
    return _collectionView;
}

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [[NSMutableArray alloc] init];
    }
    return _shops;
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
