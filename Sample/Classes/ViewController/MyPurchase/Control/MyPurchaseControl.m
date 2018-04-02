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

@interface MyPurchaseControl ()
{
    NSArray *testArr;
}

@end

@implementation MyPurchaseControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.pulledTableView registerClass:[MyPurchaseCell class] forCellReuseIdentifier:kMyPurchaseCellReusedIdentifier];
    testArr = [[NSArray alloc] initWithObjects:@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12), nil];
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
    return testArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyPurchaseCellReusedIdentifier forIndexPath:indexPath];
    [cell testUpdateContent:[testArr[indexPath.row] integerValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cardCount = [testArr[indexPath.row] integerValue];
    NSInteger rowsCount = cardCount%2 + cardCount/2;
    CGFloat H_listView = H_MyPurchaseCard*rowsCount;
    return H_topView_myPurchaseCell + H_listView + gap_PurchaseCell_bottom_MyPurchase;
}


@end
