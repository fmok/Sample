//
//  RecordAndPlayControl.m
//  Sample
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "RecordAndPlayControl.h"

static NSString *const kSingleRecordCellReusedIdentifierStr = @"SingleRecordcell";

@implementation RecordAndPlayControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.recordListView registerClass:[SingleRecordCell class] forCellReuseIdentifier:kSingleRecordCellReusedIdentifierStr];
}

- (void)testLoadData
{
    [self.vc.recordListView reloadData];
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kSingleRecordCellReusedIdentifierStr forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

@end
