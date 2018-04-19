//
//  FMH5ViewController_wk.m
//  Sample
//
//  Created by wjy on 2018/4/16.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMH5ViewController_wk.h"
#import "UIImage+Resize.h"
#import "MJRefresh.h"

#define kH5NavBarBackViewCloseSize  25.f

@interface FMH5ViewController_wk ()<
    WKNavigationDelegate,
    WKUIDelegate,
    WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, weak) WKUserContentController *userContentController;  // 此处用weak，避免内存泄露

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation FMH5ViewController_wk

- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.wkWebView stopLoading];
    self.wkWebView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self initLayout];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self loadRequest:self.request];
}

#pragma mark - Public methods
- (instancetype)initWithAddress:(NSString*)urlString
{
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL*)URL
{
    return [self initWithURLRequest:[NSMutableURLRequest requestWithURL:URL]];
}

- (instancetype)initWithURLRequest:(NSMutableURLRequest *)request
{
    self = [super init];
    if (self) {
        self.request = request;
        self.refreshUpdatedTimeKey = [request.URL absoluteString];
    }
    return self;
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
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeBtn];
    NSArray *h5LeftBarItems = @[closeItem];
    self.fm_navigationItem.leftBarButtonItems = [self.fm_navigationItem.leftBarButtonItems arrayByAddingObjectsFromArray:h5LeftBarItems];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    self.fm_navigationItem.rightBarButtonItems = @[shareItem];
    
}

- (void)initLayout
{
    WS(weakSelf);
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(kNavBarHeight);
        } else {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(kNavBarHeight);
        }
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(2.f);
    }];
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.progressView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(weakSelf.view);
    }];
}

- (void)loadRequest:(NSMutableURLRequest*)request
{
    [self.wkWebView loadRequest:request];
}

- (void)outVC
{
    [super popVC];
}

- (void)popVC
{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        self.closeBtn.hidden = NO;
        return;
    }
    [self outVC];
}

#pragma mark - Events
- (void)shareBtnAction:(id)sender
{
    [self.view endEditing:YES];
    TTDPRINT(@"to share");
}

- (void)closeBtnAction:(id)sender
{
    [self outVC];
}

#pragma mark - WKNavigationDelegate
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    TTDPRINT(@"%@",navigationAction.request.URL.absoluteString);
//    NSString *urlStr = [navigationAction.request.URL absoluteString];
    NSString *scheme = [navigationAction.request.URL scheme];
    if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        
    } else {
        
    }
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    TTDPRINT(@"%@",navigationResponse.response.URL.absoluteString);
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    // 不允许跳转
//    decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark - WKUIDelegate
//// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
//{
//    return [[WKWebView alloc]init];
//}
//// 输入框
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
//{
//    completionHandler(@"http");
//}
//// 确认框
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
//{
//    completionHandler(YES);
//}
//// 警告框
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
//{
//    NSLog(@"%@",message);
//    completionHandler();
//}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@""]) {
        
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - getter & setter
- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        self.userContentController = configuration.userContentController;
        _wkWebView = [[WKWebView alloc] init];
        _wkWebView.navigationDelegate = self;
//        _wkWebView.UIDelegate = self;
        _wkWebView.backgroundColor = [UIColor clearColor];
        _wkWebView.scrollView.backgroundColor = [UIColor clearColor];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.tintColor =  SRGBCOLOR_HEX(0x167EFB);
    }
    return _progressView;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(0, 0, kH5NavBarBackViewCloseSize, kH5NavBarBackViewCloseSize);
        _closeBtn.transform = CGAffineTransformMakeScale(0.95, 0.95);
        _closeBtn.hidden = YES;
        [_closeBtn setImage:[UIImage imageNamed:@"top_navigation_close_h5"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(0, 0, kH5NavBarBackViewCloseSize, kH5NavBarBackViewCloseSize);
        [_shareBtn setImage:[UIImage imageNamed:@"reader_toolbar_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
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
