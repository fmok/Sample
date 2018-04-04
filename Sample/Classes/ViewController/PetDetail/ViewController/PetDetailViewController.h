//
//  PetDetailViewController.h
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import "FMTabsView.h"
#import "FMCardsStackScrollView.h"

@interface PetDetailViewController : FMBaseViewController

@property (nonatomic, strong) FMTabsView *topTabView;
@property (nonatomic, strong) FMCardsStackScrollView *petScrollView;

@property (nonatomic, assign) NSInteger currentIndexForCardScrollView;  // 初始index
@property (nonatomic, strong) NSMutableArray *dataSource;
#warning todo 根据数据源 和 初始index 设置 petScrollView 的初始化显示

- (void)updatePetName:(NSString *)name petDes:(NSString *)petDes;

@end
