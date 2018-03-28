//
//  CardListModel.h
//  Sample
//
//  Created by wjy on 2018/3/22.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CardInfoModel.h"

@protocol CardInfoModel;

@interface CardListModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *error;
@property (nonatomic, copy) NSString<Optional> *gifurl;
@property (nonatomic, copy) NSString<Optional> *route;
@property (nonatomic, copy) NSArray<Optional, CardInfoModel> *list;
@property (nonatomic, copy) NSString<Optional> *nextSign;
@property (nonatomic, copy) NSString<Optional> *isUneva;

/**
    后面的字段暂未处理，主要处理list
 */

@end
