//
//  MeControl.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MeControl.h"
#import "CardDetailViewController.h"
#import "FMAlertView.h"

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
#if 1
    FMAlertView *alert = [[FMAlertView alloc] initWithStyle:CancelAndConfirmAlert width:0.8];
    alert.isClickBackgroundCloseWindow = YES;
    [alert setTitleText:@"当前价格: 500LUK" contentText:@"每位用户在该卡牌预售期仅能持有一张" confirmBtnText:@"确认购买" cancelBtnText:@"取消"];
    alert.confirm = ^(){
        TTDPRINT(@"Confirm");
    };
    alert.cancel = ^(){
        TTDPRINT(@"Cancel");
    };
    [alert show];
#else
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前价格: 500LUK" message:@"每位用户在该卡牌预售期仅能持有一张" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认购买", nil];
    [alert show];
#endif
    
    
    
//    CardDetailViewController *vc = [[CardDetailViewController alloc] init];
//    vc.title = [NSString stringWithFormat:@"%@ - %@", @(indexPath.section), @(indexPath.row)];
//    [self.vc.zl_navigationController pushViewController:vc animated:YES];
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

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //头部放大相关
    if ([change[@"new"] CGPointValue].y <= 0) {
        CGFloat multi = H_MeHeaderView/W_MeHeaderView;
        CGFloat tmp = 1 + (fabs([change[@"new"] CGPointValue].y)/(self.vc.mePulledTableView.ml_width*multi));
        self.vc.headerView.imgView.transform = CGAffineTransformMake(tmp, 0, 0, tmp, 0, ([change[@"new"] CGPointValue].y)/2.f);
    } else {
        self.vc.headerView.imgView.transform = CGAffineTransformIdentity;
    }
}

@end
