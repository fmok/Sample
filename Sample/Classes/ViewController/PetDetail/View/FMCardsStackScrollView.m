//
//  FMCardsStackScrollView.m
//  Sample
//
//  Created by wjy on 2018/4/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMCardsStackScrollView.h"
#import "PulledCollectionView.h"

static NSString *const kCardStackSingleCellReusedIdentifier = @"CardStackSingleCell";

@interface FMCardsStackScrollView ()<
    UICollectionViewDelegate,
    UICollectionViewDataSource>
{
    NSInteger currentCardIndex;
    NSArray *testUrlArr;
}

@property (nonatomic, strong) PulledCollectionView *cardCollectionView;

@end

@implementation FMCardsStackScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.cardCollectionView];
        [self.cardCollectionView registerClass:[CardStackSingleCell class] forCellWithReuseIdentifier:kCardStackSingleCellReusedIdentifier];
        currentCardIndex = 0;
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
    }
    return self;
}

#pragma mark - Public methods
- (void)updateContent
{
    [self.cardCollectionView reloadData];
}

- (void)setInitailIndexCard:(NSInteger)idx
{
    currentCardIndex = idx;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
    [self.cardCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTDPRINT(@"\n*** %@ - %@ ***\n", @(indexPath.section), @(indexPath.item));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardStackSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCardStackSingleCellReusedIdentifier forIndexPath:indexPath];
    [cell updateContentWithImgUrl:[testUrlArr objectAtIndex:indexPath.item]];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint pInView = [self convertPoint:self.cardCollectionView.center toView:self.cardCollectionView];
    NSIndexPath *indexPathNow = [self.cardCollectionView indexPathForItemAtPoint:pInView];
    if (self.cardStackScrollDelegate && [self.cardStackScrollDelegate respondsToSelector:@selector(cardScrollToIndex:)]) {
        currentCardIndex = indexPathNow.item;
        [self.cardStackScrollDelegate cardScrollToIndex:indexPathNow.item];
    }
}

#pragma mark - getter & setter
- (PulledCollectionView *)cardCollectionView
{
    if (!_cardCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, H_CardsStackSingleCell);
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.minimumLineSpacing = 0.0f;
        _cardCollectionView = [[PulledCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, H_CardsStackSingleCell) collectionViewLayout:flowLayout];
        _cardCollectionView.backgroundColor = [UIColor clearColor];
        _cardCollectionView.alwaysBounceHorizontal = YES;
        _cardCollectionView.directionalLockEnabled = YES;
        _cardCollectionView.scrollsToTop = NO;
        _cardCollectionView.pagingEnabled = YES;
        _cardCollectionView.bounces = NO;
        _cardCollectionView.showsHorizontalScrollIndicator = NO;
        _cardCollectionView.delegate = self;
        _cardCollectionView.dataSource = self;
        _cardCollectionView.isHeader = NO;
        _cardCollectionView.isFooter = NO;
    }
    return _cardCollectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
