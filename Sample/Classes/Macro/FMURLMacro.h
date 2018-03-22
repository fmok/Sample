//
//  FMURLMacro.h
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#ifndef FMURLMacro_h
#define FMURLMacro_h

// base url
#define kJiemianURL     (@"jiemian.com")
#define kProtocol       (@"https")
#define kAppapiDoman    ([NSString stringWithFormat:@"appapi.%@",kJiemianURL])
#define kAPIBaseURL     ([NSString stringWithFormat:@"%@://%@/",kProtocol,kAppapiDoman])
#define kAJiemianURL    ([NSString stringWithFormat:@"%@://a.%@/",kProtocol,kJiemianURL])


#endif /* FMURLMacro_h */
