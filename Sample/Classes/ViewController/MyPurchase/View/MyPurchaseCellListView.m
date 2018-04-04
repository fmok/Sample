//
//  MyPurchaseCellListView.m
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "MyPurchaseCellListView.h"
#import "PulledCollectionView.h"
#import "MyPurchaseCard.h"
#import "MyPurchaseSizeMacro.h"
#import "PetDetailViewController.h"

static NSString *const kMyPurchaseCardReusedIdentifier = @"MyPurchaseCard";

@interface MyPurchaseCellListView ()<
    UICollectionViewDelegate,
    UICollectionViewDataSource>
{
    NSInteger cardCount;
}

@property (nonatomic, strong) PulledCollectionView *listView;

@end

@implementation MyPurchaseCellListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        WS(weakSelf);
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.listView];
        [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        [self registerCell];
        cardCount = 0;
    }
    return self;
}

#pragma mark - Public methods
- (void)testUpdateContent:(NSInteger)count
{
    cardCount = count;
    [self.listView reloadData];
}

#pragma mark - Private methods
- (void)registerCell
{
    [self.listView registerClass:[MyPurchaseCard class] forCellWithReuseIdentifier:kMyPurchaseCardReusedIdentifier];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTDPRINT(@"\n*** %@ - %@ ***\n", @(indexPath.section), @(indexPath.item));
    PetDetailViewController *vc = [[PetDetailViewController alloc] init];
    [vc updatePetName:@"双鱼座·风向" petDes:@"植物系 T1002-01代"];
    vc.currentIndexForCardScrollView = indexPath.item;
    [[FMUtility topNav] pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return cardCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyPurchaseCard *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyPurchaseCardReusedIdentifier forIndexPath:indexPath];
    [cell testUpdateContent];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(W_MyPurchaseCard, H_MyPurchaseCard);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CGFLOAT_MIN, gap_left_right_MyPurchaseCard, CGFLOAT_MIN, gap_left_right_MyPurchaseCard);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark - getter & setter
- (PulledCollectionView *)listView
{
    if (!_listView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.estimatedItemSize = CGSizeZero;
        _listView = [[PulledCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _listView.backgroundColor = [UIColor clearColor];
        _listView.isHeader = NO;
        _listView.isFooter = NO;
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.scrollEnabled = NO;
    }
    return _listView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
