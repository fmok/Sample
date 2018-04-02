//
//  PetDetailViewController.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PetDetailViewController.h"
#import "PetDetailControl.h"

#define H_TopView_PetDetail (kScreenWidth*(120.f/375.f))

@interface PetDetailViewController ()

@property (nonatomic, strong) PetDetailControl *control;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UILabel *petDesLabel;
@property (nonatomic, strong) FMSegmentControl *segmentControl;

@end

@implementation PetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(weakSelf);
    [self.view addSubview:self.topImgView];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_TopView_PetDetail);
    }];
    
    [self.view addSubview:self.petDesLabel];
    [self.petDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.zl_navigationBar);
        make.center.equalTo(weakSelf.view);
    }];
}

- (void)viewDidLayoutSubviews
{
    TTDPRINT(@"%@", self.zl_navigationBar);
}

#pragma mark - Public methods
- (void)updatePetDes:(NSString *)petDes
{
    self.petDesLabel.text = CHANGE_TO_STRING(petDes);
}

#pragma mark - getter & setter
- (PetDetailControl *)control
{
    if (!_control) {
        _control = [[PetDetailControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (UIImageView *)topImgView
{
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _topImgView.backgroundColor = [UIColor purpleColor];
    }
    return _topImgView;
}

- (UILabel *)petDesLabel
{
    if (!_petDesLabel) {
        _petDesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _petDesLabel.backgroundColor = [UIColor redColor];
        _petDesLabel.textColor = [UIColor whiteColor];
        _petDesLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _petDesLabel;
}

- (FMSegmentControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[FMSegmentControl alloc] initWithFrame:CGRectZero items:@[] configureDic:nil currentIndex:0];
//        _segmentControl.delegate = self.control;
    }
    return _segmentControl;
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
