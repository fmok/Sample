//
//  CardDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CardDetailViewController.h"
#import "CardDetailControl.h"

@interface CardDetailViewController ()

@property (nonatomic, strong) CardDetailControl *control;

@end

@implementation CardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavBarBackgroundImage:[UIImage imageNamed:@"nav.png"]];
    WS(weakSelf);
    [self.view addSubview:self.pulledCollectionView];
    [self.pulledCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.control registerCell];
}


#pragma mark - getter & setter
- (PulledCollectionView *)pulledCollectionView
{
    if (!_pulledCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _pulledCollectionView = [[PulledCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _pulledCollectionView.backgroundColor = [UIColor clearColor];
        _pulledCollectionView.bounces = YES;
        _pulledCollectionView.alwaysBounceVertical = YES;
        _pulledCollectionView.delegate = self.control;
        _pulledCollectionView.dataSource = self.control;
        _pulledCollectionView.pulledDelegate = self.control;
        _pulledCollectionView.isHeader = YES;
        _pulledCollectionView.isFooter = YES;
    }
    return _pulledCollectionView;
}

- (CardDetailControl *)control
{
    if (!_control) {
        _control = [[CardDetailControl alloc] init];
        _control.vc = self;
    }
    return _control;
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
