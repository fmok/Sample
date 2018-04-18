//
//  FMCardScrollViewController.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCardScrollViewController.h"
#import "FMCardScrollControl.h"
#import "UIImage+Resize.h"
#import "CardsScrollView.h"

@interface FMCardScrollViewController ()
{
    NSMutableArray *testUrlArr;
}

@property (nonatomic, strong) FMCardScrollControl *control;

@end

@implementation FMCardScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    testUrlArr = @[
                   @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1003875183,1486960090&fm=27&gp=0.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855285&di=03335c88fd6f213a141900b34dcf68f2&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F11%2F71%2F05%2F04A58PICRuB.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855285&di=297f7b2bd3ddc5a7d1bac1263bcfeef1&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F54fbb2fb43166d22576636864c2309f79052d28a.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855285&di=eeb1b9d89435fecca8411924599c73f2&imgtype=0&src=http%3A%2F%2Feasyread.ph.126.net%2FzUeEFxHex3ohEHM8uHUcew%3D%3D%2F7916786085686652223.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855285&di=b294f0b14a51051b371abdc917b54b70&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fe850352ac65c10387d41d2d6b8119313b07e89e2.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855285&di=7cbe3492379843d48e80fa1995ba7829&imgtype=0&src=http%3A%2F%2Fnews.xinhuanet.com%2Fscience%2F2015-10%2F12%2F134706532_14446448951551n.png",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855285&di=69ded2b5d609d5f55625a04d6bd1d4a6&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D111d29a26681800a7ae8814dd95c598f%2F18d8bc3eb13533fa42ce4303a2d3fd1f41345ba7.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855284&di=aa610673c343fd487c048860634a5386&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F015f5356342b0d32f87512f6afe196.jpg%40900w_1l_2o_100sh.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855284&di=28e4a0cc87f3bc166c0027af2bf8fdd5&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F16%2F45%2F73%2F64P58PICknj_1024.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855284&di=62bcc687982a415167bbf5df702607e1&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D043bdf14ab8b87d6444fa35c6f61424d%2F267f9e2f07082838a817b131b299a9014c08f1f9.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855283&di=0b1796f2960dc89e010d434d163f3061&imgtype=0&src=http%3A%2F%2Fchinadmd.zyexhibition.com%2Fupload%2F15_2do75x32a382a2k157xd3x5b.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522832855283&di=5055948873ff244e4d910a8be8d0f738&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F45%2F48%2F86R58PICfF6_1024.jpg"
                   ];
    
    CardsScrollView *cardScrollView  = [[CardsScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.ml_width, self.view.ml_height/2.f)];
    cardScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cardScrollView];
    
    [cardScrollView setCards:testUrlArr];
}

- (void)setUpNav
{
    [self configNavBarBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.fm_navigationBar.tintColor = [UIColor blackColor];
    self.fm_navigationBar.titleTextAttributes = @{
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f],
                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                  };
}

#pragma mark - getter & setter
- (FMCardScrollControl *)control
{
    if (!_control) {
        _control = [[FMCardScrollControl alloc] init];
        _control.vc = self;
    }
    return _control;
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
