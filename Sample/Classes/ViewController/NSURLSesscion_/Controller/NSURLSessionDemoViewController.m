//
//  NSURLSessionDemoViewController.m
//  Sample
//
//  Created by wjy on 2018/4/25.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "NSURLSessionDemoViewController.h"
#import "NSURLSessionDemoControl.h"
#import "UIImage+Resize.h"
#import <MediaPlayer/MediaPlayer.h>

#define FileName @"xx_cc.mp4"
#define FileLength @"xx_cc.xx"

static CGFloat const gap_left_right = 20.f;

@interface NSURLSessionDemoViewController ()<NSURLSessionDataDelegate>
{
    BOOL isDownLoading;
}

@property (nonatomic, strong) NSURLSessionDemoControl *control;

@property (nonatomic, strong) NSOutputStream *stream;  // 输出流
@property (nonatomic, assign) NSInteger totalLength;  // 文件总大小
@property (nonatomic, assign) NSInteger currentLength;  // 已经下载大小
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *stopBtn;
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation NSURLSessionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self configUI];
    
    self.playBtn.enabled = NO;
    NSString *caches =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:FileLength];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if (dict) {
        self.progressView.progress = 1.0 * [self getCurrent]/[dict[FileLength] integerValue];
        if (self.progressView.progress == 1) {
            self.playBtn.enabled = YES;
        }
    }
    TTDPRINT(@"%@",dict);
}

#pragma mark - Private
- (void)setUpNav
{
    [self configNavBarBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.fm_navigationBar.tintColor = [UIColor blackColor];
    self.fm_navigationBar.titleTextAttributes = @{
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f],
                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                  };
}

- (void)configUI
{
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.startBtn];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.progressView.mas_bottom).offset(80.f);
    }];
    [self.view addSubview:self.stopBtn];
    [self.stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.startBtn.mas_bottom).offset(80.f);
    }];
    [self.view addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.stopBtn.mas_bottom).offset(80.f);
    }];
}

- (NSInteger )getCurrent
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:FileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *dict = [manager attributesOfItemAtPath:filePath error:nil];
    return [dict[@"NSFileSize"] integerValue];
}

- (void)saveTotal:(NSInteger )length
{
    TTDPRINT(@"开始存储文件大小");
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:FileLength];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(length) forKey:FileLength];
    [dict writeToFile:filePath atomically:YES];
}

#pragma mark - Events
- (void)startAction:(UIButton *)sender
{
    if (isDownLoading) {
        TTDPRINT(@"is downLoading");
        return;
    }
    isDownLoading = YES;
    [self.dataTask resume];
    TTDPRINT(@"start");
}

- (void)stopAction:(UIButton *)sender
{
    if (!isDownLoading) {
        TTDPRINT(@"It's over");
        return;
    }
    isDownLoading = NO;
    [self.dataTask suspend];
    TTDPRINT(@"pause");
}

- (void)playAction:(UIButton *)sender
{
    NSString *caches =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:FileName];
    
    NSURL*videoPathURL=[[NSURL alloc] initFileURLWithPath:filePath];
    
    MPMoviePlayerViewController *vc =[[MPMoviePlayerViewController alloc]initWithContentURL:videoPathURL];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - NSURLSessionDataDelegate
// 接收到服务器响应的时候调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    // 拿到文件总大小 获得的是当次请求的数据大小，当我们关闭程序以后重新运行，开下载请求的数据是不同的 ,所以要加上之前已经下载过的内容
    TTDPRINT(@"接收到服务器响应");
    self.totalLength = response.expectedContentLength + self.currentLength;
    // 把文件总大小保存的沙盒 没有必要每次都存储一次,只有当第一次接收到响应，self.currentLength为零时，存储文件总大小就可以了
    if (self.currentLength == 0) {
        [self saveTotal:self.totalLength];
    }
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:FileName];
    NSLog(@"%@",filePath);
    // 创建输出流 如果没有文件会创建文件，YES：会往后面进行追加
    NSOutputStream *stream = [[NSOutputStream alloc]initToFileAtPath:filePath append:YES];
    [stream open];
    self.stream = stream;
    //NSLog(@"didReceiveResponse 接受到服务器响应");
    completionHandler(NSURLSessionResponseAllow);
}
// 接收到服务器返回数据时调用，会调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    self.currentLength += data.length;
    // 输出流写数据
    [self.stream write:data.bytes maxLength:data.length];
    TTDPRINT(@"%f",1.0 * self.currentLength / self.totalLength);
    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;
    //NSLog(@"didReceiveData 接受到服务器返回数据");
}
// 当请求完成之后调用，如果请求失败error有值
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    // 关闭stream
    [self.stream close];
    self.stream = nil;
    TTDPRINT(@"didCompleteWithError 请求完成");
    self.playBtn.enabled = YES;
}

#pragma mark - getter & setter
- (NSURLSessionDemoControl *)control
{
    if (!_control) {
        _control = [[NSURLSessionDemoControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (NSURLSessionDataTask *)dataTask
{
    if (!_dataTask) {
        self.currentLength = [self getCurrent];
        NSURL *url =[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSString *range =[NSString stringWithFormat:@"bytes=%zd-",self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        _dataTask = [self.session dataTaskWithRequest:request];
    }
    return _dataTask;
}

-(NSURLSession *)session
{
    if (!_session) {
        // 使用代理方法请求
        /**
         参数一：配置信息
         参数二：代理
         参数三：控制代理方法在那个队列中调用
         遵守代理:NSURLSessionDataDelegate
         */
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(gap_left_right, kNavBarAndStateHeight+50.f, kScreenWidth-gap_left_right*2, 5.f)];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor blueColor];
    }
    return _progressView;
}

- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_startBtn setTitle:@"开始/继续" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:40.f];
        [_startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _startBtn.backgroundColor = [UIColor redColor];
        [_startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

- (UIButton *)stopBtn
{
    if (!_stopBtn) {
        _stopBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _stopBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_stopBtn setTitle:@"暂停" forState:UIControlStateNormal];
        _stopBtn.titleLabel.font = [UIFont systemFontOfSize:40.f];
        [_stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _stopBtn.backgroundColor = [UIColor redColor];
        [_stopBtn addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopBtn;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _playBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        _playBtn.titleLabel.font = [UIFont systemFontOfSize:40.f];
        [_playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _playBtn.backgroundColor = [UIColor redColor];
        [_playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
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
