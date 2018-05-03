//
//  DBPersonModel.h
//  Sample
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DBPersonModel : JSONModel

@property (nonatomic, copy) NSString *personID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *data;

@end
