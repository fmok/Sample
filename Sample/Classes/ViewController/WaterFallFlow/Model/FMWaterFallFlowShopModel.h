//
//  FMWaterFallFlowShopModel.h
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FMWaterFallFlowShopModel : JSONModel

/** 宽度  */
@property (nonatomic, assign) CGFloat w;
/** 高度  */
@property (nonatomic, assign) CGFloat h;
/** 图片  */
@property (nonatomic, copy) NSString *img;
/** 价格  */
@property (nonatomic, copy) NSString *price;

@end
