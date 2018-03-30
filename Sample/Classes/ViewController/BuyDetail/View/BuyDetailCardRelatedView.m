//
//  BuyDetailCardRelatedView.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "BuyDetailCardRelatedView.h"
#import "PulledTableView.h"
#import "FMSegmentControl.h"

static NSString *const segmentControl_description = @"描述";
static NSString *const segmentControl_purchaseRecords = @"购买记录";

#define H_SegmentControl 39.f

@interface BuyDetailCardRelatedView ()<
    UITableViewDelegate,
    UITableViewDataSource,
    FMSegmentControlDelegate>

@property (nonatomic, strong) FMSegmentControl *segmentControl;
@property (nonatomic, strong) PulledTableView *purchaseRecordsList;

@end

@implementation BuyDetailCardRelatedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        [self addSubview:self.segmentControl];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(H_SegmentControl);
    }];
    
    [super updateConstraints];
}

#pragma mark - FMSegmentControlDelegate
- (void)segmentedControl:(FMSegmentControl *)segment didSeletedItemAtIndex:(NSInteger)index
{
    TTDPRINT(@"segmentControl: %@", @(index));
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - getter & setter
- (FMSegmentControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[FMSegmentControl alloc] initWithFrame:CGRectZero items:@[segmentControl_description, segmentControl_purchaseRecords] configureDic:nil currentIndex:0];
        _segmentControl.delegate = self;
    }
    return _segmentControl;
}

- (PulledTableView *)purchaseRecordsList
{
    if (!_purchaseRecordsList) {
        _purchaseRecordsList = [[PulledTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _purchaseRecordsList.estimatedRowHeight = 0;
        _purchaseRecordsList.estimatedSectionHeaderHeight = 0;
        _purchaseRecordsList.estimatedSectionFooterHeight = 0;
        _purchaseRecordsList.isHeader = NO;
        _purchaseRecordsList.isFooter = NO;
        _purchaseRecordsList.delegate = self;
        _purchaseRecordsList.dataSource = self;
    }
    return _purchaseRecordsList;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
