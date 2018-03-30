//
//  MyPurchaseControl.m
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseControl.h"
#import "MyPurchaseCell.h"

static NSString *const kMyPurchaseCellReusedIdentifier = @"kMyPurchaseCellReusedIdentifier";

@implementation MyPurchaseControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.pulledTableView registerClass:[MyPurchaseCell class] forCellReuseIdentifier:kMyPurchaseCellReusedIdentifier];
}

- (void)loadData
{
    
}

#pragma mark - Private methods


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTDPRINT(@"*** %@ ***", @(indexPath.row));
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyPurchaseCellReusedIdentifier forIndexPath:indexPath];
    [cell updateContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

@end
