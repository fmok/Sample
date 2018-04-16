//
//  FMH5ViewController_wk.h
//  Sample
//
//  Created by wjy on 2018/4/16.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"

@import WebKit;

@interface FMH5ViewController_wk : FMBaseViewController

@property (nonatomic, strong) NSURL *browseUrl;
@property (nonatomic, assign) BOOL isRefresh;  // 是否要MJRefresh下拉刷新,默认是不加
@property (nonatomic, strong) NSString *refreshUpdatedTimeKey;  // 刷新控件刷新key值
@property (nonatomic, assign) BOOL isOpenMode;  // YES：打开新页； NO：本页刷新

- (instancetype)initWithAddress:(NSString*)urlString;
- (instancetype)initWithURL:(NSURL*)URL;
- (instancetype)initWithURLRequest:(NSURLRequest *)request;

@end
