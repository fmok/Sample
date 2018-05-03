//
//  DBViewController.m
//  Sample
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DBViewController.h"
#import "UIImage+Resize.h"
#import "DBPersonModel.h"

@interface DBViewController ()

@end

@implementation DBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self installDB];
    [self testDB];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self getItem];
}

#pragma mark - Private methods
- (void)setUpNav
{
    [self configNavBarBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.fm_navigationBar.tintColor = [UIColor blackColor];
    self.fm_navigationBar.titleTextAttributes = @{
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f],
                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                  };
    
}

- (void)getItem
{
    NSArray<DBPersonModel *> *itemList = J_Select(DBPersonModel)
    .Where(@"personID = ?")
    .Params(@[@"Person1"])
    .list;
    if (itemList && itemList.count > 0) {
        TTDPRINT(@"%@", itemList[0]);
    }
}

- (void)testDB
{
    DBPersonModel *person = [[DBPersonModel alloc] init];
    person.personID = @"Person1";
    person.name = @"Andy";
    person.age = 30;
    person.data = @"abcdefg哈哈哈";
    [person jr_save];
}

- (void)installDB
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullPath = [path stringByAppendingString:@"Sample.db"];
    TTDPRINT(@"fullPath: %@", fullPath);
    [[JRDBMgr shareInstance] setDefaultDatabasePath:fullPath];
    [[JRDBMgr shareInstance] registerClazz:[DBPersonModel class]];
    J_CreateTable(DBPersonModel);
    [JRDBMgr shareInstance].debugMode = YES;
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
