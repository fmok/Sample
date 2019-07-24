//
//  FMUrlArgumentsFilter.h
//  Sample
//
//  Created by wjy on 2019/7/24.
//  Copyright © 2019 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (FMUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

@end

NS_ASSUME_NONNULL_END
