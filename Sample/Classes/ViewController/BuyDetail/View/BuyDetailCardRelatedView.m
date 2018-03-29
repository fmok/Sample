//
//  BuyDetailCardRelatedView.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "BuyDetailCardRelatedView.h"
#import "PulledTableView.h"

@interface BuyDetailCardRelatedView ()<
    UITableViewDelegate,
    UITableViewDataSource>

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
    }
    return self;
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
