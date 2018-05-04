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
    NSString *primaryKetStr = [DBPersonModel jr_primaryKey];
    NSArray<DBPersonModel *> *itemList = J_Select(DBPersonModel)
    .Where([NSString stringWithFormat:@"%@ = ?", primaryKetStr])
    .Params(@[@"Person1"])
    .Where(@"name like ?")
    .Params(@[@"Bruce"])
//    .Where(@"name like ? and age > ?")
//    .Params(@[@"Bruce", @10])
    .list;
    if (itemList && itemList.count > 0) {
        TTDPRINT(@"\n%@\nprimaryKeyValue = %@\n", [itemList firstObject], [[itemList firstObject] jr_primaryKeyValue]);
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
    
    
    DBPersonModel *person2 = [[DBPersonModel alloc] init];
    person2.personID = @"Person2";
    person2.name = @"Bruce";
    person2.age = 20;
    person2.data = @"abcdefg嘿嘿嘿";
    [person2 jr_saveOrUpdate];
    
    
    DBPersonModel *person3 = [[DBPersonModel alloc] init];
    person3.personID = @"Person3";
    person3.name = @"Bruce";
    person3.age = 40;
    person3.data = @"abcdefg呵呵呵";
    [person3 jr_saveOrUpdate];
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
