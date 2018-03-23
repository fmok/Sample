//
//  Control.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "Control.h"
#import "SampleListAPI.h"
#import "HUD.h"
#import "CardListModel.h"
#import "UIImageView+WebCache.h"
#import "JSONKit.h"

static NSString *const kCellReusedIdentifier = @"kCellReusedIdentifier";

@interface Control()
{
    SampleListAPI *refreshAPI;
}

@end

@implementation Control

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.pulledTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReusedIdentifier];
}

- (void)testRequest
{
    WS(weakSelf);
    refreshAPI = [[SampleListAPI alloc] init];
    [refreshAPI startWithJsonModelClass:[CardListModel class] success:^(FMRequest *request, id modelObj) {
        if ([request responseIsNormal]) {
            [weakSelf serializeData:modelObj];
        } else {
            // 业务错误
            [HUD showTipWithText:request.responseJMMessage];
        }
    } failure:^(FMRequest *request, id modelObj) {
        // 网络错误
        [HUD showTipWithText:modelObj];
    }];
}

#pragma mark - Private methods
- (void)serializeData:(CardListModel *)modelObj
{
    [self.vc.cardInfoArr addObjectsFromArray:modelObj.list];
    
//    NSArray *imageUrls = [model.img_url objectFromJSONString];
//    [self.vc.tmpImgView sd_setImageWithURL:[NSURL URLWithString:[imageUrls firstObject]] placeholderImage:nil options:SDWebImageRetryFailed];
}


#pragma mark - PulledTableViewDelegate
- (void)refreshWithPulledTableView:(PulledTableView *)tableView
{
    
}

- (void)loadMoreWithPulledTableView:(PulledTableView *)tableView
{
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.vc.navigationController pushViewController:vc animated:YES];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReusedIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"**%@**", @(indexPath.row)];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end







