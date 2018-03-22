//
//  CardInfoModel.h
//  Sample
//
//  Created by wjy on 2018/3/22.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CardInfoModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *_id;
@property (nonatomic, copy) NSString<Optional> *img_url;
@property (nonatomic, copy) NSString<Optional> *text;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *addTime;
@property (nonatomic, copy) NSString<Optional> *goto_url;
@property (nonatomic, copy) NSString<Optional> *istop;
@property (nonatomic, copy) NSString<Optional> *desc;
@property (nonatomic, copy) NSString<Optional> *beginTime;
@property (nonatomic, copy) NSString<Optional> *endTime;
@property (nonatomic, copy) NSString<Optional> *uid;
@property (nonatomic, copy) NSString<Optional> *time;
@property (nonatomic, copy) NSString<Optional> *uname;
@property (nonatomic, copy) NSString<Optional> *click_txt;
@property (nonatomic, copy) NSString<Optional> *del_key;
@property (nonatomic, copy) NSString<Optional> *cc_icon;

@end
