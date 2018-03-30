//
//  BuyDetailCardRelatedView.m
//  Sample
//
//  Created by wjy on 2018/3/29.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "BuyDetailCardRelatedView.h"
#import "FMSegmentControl.h"
#import "SwipeView.h"
#import "PurchaseRecordsViewController.h"
#import "DescripationViewController.h"

static NSString *const segmentControl_description = @"描述";
static NSString *const segmentControl_purchaseRecords = @"购买记录";

#define H_SegmentControl 39.f

@interface BuyDetailCardRelatedView ()<
    FMSegmentControlDelegate,
    SwipeViewDelegate,
    SwipeViewDataSource>

@property (nonatomic, strong) FMSegmentControl *segmentControl;
@property (nonatomic, strong) SwipeView *swipeView;
@property (nonatomic, strong) NSMutableArray<FMBaseViewController *> *viewControllerStack;

@end

@implementation BuyDetailCardRelatedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        [self addSubview:self.segmentControl];
        [self addSubview:self.swipeView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(H_SegmentControl);
    }];
    [self.swipeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.segmentControl.mas_bottom);
        make.left.and.right.and.bottom.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - FMSegmentControlDelegate
- (void)segmentedControl:(FMSegmentControl *)segment didSeletedItemAtIndex:(NSInteger)index
{
    TTDPRINT(@"segmentControl: %@", @(index));
    [self.swipeView scrollToItemAtIndex:index duration:0];
}

#pragma mark - SwipeViewDataSource
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.viewControllerStack.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    return self.viewControllerStack[index].view;
}

#pragma mark - SwipeViewDelegate
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return CGSizeMake(self.ml_width, self.ml_height-H_SegmentControl);
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    [self.segmentControl scrollByProgress:swipeView.scrollOffset];
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView
{
    
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate
{
    
}

- (void)swipeViewWillBeginDecelerating:(SwipeView *)swipeView
{
    
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    
}

- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView
{
    
}

- (BOOL)swipeView:(SwipeView *)swipeView shouldSelectItemAtIndex:(NSInteger)index
{
    return YES;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    
}

#pragma mark - getter & setter
- (FMSegmentControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[FMSegmentControl alloc] initWithFrame:CGRectZero items:@[segmentControl_description, segmentControl_purchaseRecords] configureDic:nil currentIndex:0];
        _segmentControl.delegate = self;
    }
    return _segmentControl;
}

- (SwipeView *)swipeView
{
    if (!_swipeView) {
        _swipeView = [[SwipeView alloc] initWithFrame:CGRectZero];
        _swipeView.delegate = self;
        _swipeView.dataSource = self;
    }
    return _swipeView;
}

- (NSMutableArray<FMBaseViewController *> *)viewControllerStack
{
    if (!_viewControllerStack) {
        _viewControllerStack = [[NSMutableArray alloc] initWithObjects:[[DescripationViewController alloc] init], [[PurchaseRecordsViewController alloc] init], nil];
    }
    return _viewControllerStack;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
