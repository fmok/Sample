//
//  PurchaseRecordsViewController.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PurchaseRecordsViewController.h"
#import "PulledTableView.h"

typedef NS_ENUM(NSInteger, PurchaseRecordsScrollType) {
    PurchaseRecordsScrollTypeAdd,
    PurchaseRecordsScrollTypeMul
};

CGFloat const step = 0.8;

@interface PurchaseRecordsViewController ()<
    UITableViewDelegate,
    UITableViewDataSource>
{
    CADisplayLink *_link;
    CGFloat distance;
    NSArray *testArr;
    PurchaseRecordsScrollType currentType;
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
    currentType = PurchaseRecordsScrollTypeAdd;
    testArr = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20];
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
    if (distance >= self.purchaseRecordsList.contentSize.height-self.purchaseRecordsList.ml_height && currentType == PurchaseRecordsScrollTypeAdd) {
        [self pauseAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            currentType = PurchaseRecordsScrollTypeMul;
            [self addTimer];
        });
    } else if (distance <= 0 && currentType == PurchaseRecordsScrollTypeMul) {
        [self pauseAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            currentType = PurchaseRecordsScrollTypeAdd;
            [self addTimer];
        });
    } else {
        switch (currentType) {
            case PurchaseRecordsScrollTypeAdd:
            {
                distance += step;
            }
                break;
            case PurchaseRecordsScrollTypeMul:
            {
                distance -= step;
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.f;
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
    return testArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tmp = [[testArr objectAtIndex:indexPath.row] integerValue];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"*** %@ ***", @(tmp)];
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
