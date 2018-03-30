//
//  PurchaseRecordsViewController.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "PurchaseRecordsViewController.h"
#import "PulledTableView.h"

@interface PurchaseRecordsViewController ()<
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, strong) PulledTableView *purchaseRecordsList;

@end

@implementation PurchaseRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(weakSelf);
    [self.view addSubview:self.purchaseRecordsList];
    [self.purchaseRecordsList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.purchaseRecordsList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"*** %@ ***", @(indexPath.row)];
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
        _purchaseRecordsList.delegate = self;
        _purchaseRecordsList.dataSource = self;
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
