//
//  MeControl.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeControl.h"
#import "CardDetailViewController.h"

static NSString *const kCellReusedIdentifierStr = @"cellReusedIdentifierStr";

@implementation MeControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.mePulledTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReusedIdentifierStr];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardDetailViewController *vc = [[CardDetailViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%@ - %@", @(indexPath.section), @(indexPath.row)];
    [self.vc.zl_navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReusedIdentifierStr forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"** %@ **", @(indexPath.row)];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

@end
