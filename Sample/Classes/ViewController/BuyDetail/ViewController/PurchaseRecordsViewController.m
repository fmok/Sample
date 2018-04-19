//
//  PurchaseRecordsViewController.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PurchaseRecordsViewController.h"
#import "PulledTableView.h"

static CGFloat const step = 0.8;
static CGFloat const cellHeight = 30.f;

@interface PurchaseRecordsViewController ()<
    UITableViewDelegate,
    UITableViewDataSource>
{
    CADisplayLink *_link;
    CGFloat distance;
    NSMutableArray *testArr;
    BOOL isNeedScroll;
}
@property (nonatomic, strong) PulledTableView *purchaseRecordsList;

@end

@implementation PurchaseRecordsViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeTimer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self beginAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    distance = 0;
    testArr = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20]];
//    [testArr addObjectsFromArray:testArr];
    WS(weakSelf);
    [self.view addSubview:self.purchaseRecordsList];
    [self.purchaseRecordsList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.purchaseRecordsList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Private methods
- (void)beginAnimation
{
    [self addTimer];
}

- (void)pauseAnimation
{
    if (!_link.isPaused) {
        [_link setPaused:YES];
    }
}

- (void)addTimer
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkStepHandler)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    if (_link.isPaused) {
        [_link setPaused:NO];
    }
}

- (void)removeTimer
{
    [_link invalidate];
    _link = nil;
}


- (void)linkStepHandler
{
    [self.purchaseRecordsList setContentOffset:CGPointMake(0, distance)];
    distance += step;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor whiteColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 999;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger index = 0;
    if (index >= testArr.count) {
        index = 1;
    } else {
        index += 1;
    }
    NSInteger tmp = [[testArr objectAtIndex:index-1] integerValue];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"***&&&### %@ ###&&&***", @(tmp)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - getter & setter
- (PulledTableView *)purchaseRecordsList
{
    if (!_purchaseRecordsList) {
        _purchaseRecordsList = [[PulledTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _purchaseRecordsList.estimatedRowHeight = 0;
//        _purchaseRecordsList.estimatedSectionHeaderHeight = 0;
//        _purchaseRecordsList.estimatedSectionFooterHeight = 0;
        _purchaseRecordsList.isHeader = NO;
        _purchaseRecordsList.isFooter = NO;
        _purchaseRecordsList.scrollsToTop = NO;
        _purchaseRecordsList.delegate = self;
        _purchaseRecordsList.dataSource = self;
        _purchaseRecordsList.scrollEnabled = NO;
    }
    return _purchaseRecordsList;
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
