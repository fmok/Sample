//
//  CardsScrollView.m
//  Sample
//
//  Created by wjy on 2018/4/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "CardsScrollView.h"
#import "CardView.h"

#define kCardMaxCount 3

#define kHorizontalSpacing 25.0f //左右间距

#define kVerticalSpacting 55.0f //上下间距

#define kCardSpacting 25.f//卡片距离

#define UIColorFromHexA(hexValue, a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]

#define kCGAffineTransformMakeScale(i) CGAffineTransformMakeScale(1-(i > kCardMaxCount?kCardMaxCount:i)*0.05, 1-(i > kCardMaxCount?kCardMaxCount:i)*0.05)
#define kCGAffineTransformTranslate(i) CGAffineTransformTranslate(cardView.transform, 0, -(i > kCardMaxCount?kCardMaxCount:i)*kCardSpacting)

@interface CardsScrollView()

// 创建卡片数量，最多三个
@property (assign, nonatomic) NSInteger itemCount;
@property (assign ,nonatomic) NSInteger lastDataIndex;

// 卡片数据，最多三个，其他复用。
@property (strong, nonatomic) NSMutableArray *cardViewArray;

@end

@implementation CardsScrollView

{
    CGPoint firstCardCenter;  // 第一张center
    CGPoint lastCardCenter;  // 最后面一张center
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(self.ml_width, self.ml_height);
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveCards:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

#pragma mark - setter
- (void)setCards:(NSMutableArray *)cards
{
    _cards = cards;
    _lastDataIndex = 0;
    
    if (_cardViewArray == nil) {
        
        _cardViewArray = [[NSMutableArray alloc] initWithCapacity:3];
        NSInteger cardCount = _cards.count>kCardMaxCount?kCardMaxCount:_cards.count;
        _itemCount = cardCount;
        
        for (NSInteger i = 0; i < cardCount; i++) {
            CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake((self.ml_width - (self.ml_width - kHorizontalSpacing * 2))/2.f,
                                                                            (self.ml_height - (self.ml_height - kVerticalSpacting * 2))/2.f - kCardSpacting/_itemCount,
                                                                            (self.ml_width - kHorizontalSpacing * 2),
                                                                            (self.ml_height - kVerticalSpacting * 2-kCardSpacting/_itemCount))];
            [self insertSubview:cardView atIndex:0];
            cardView.transform = kCGAffineTransformMakeScale(i);
            cardView.transform = kCGAffineTransformTranslate(i);
            
            if (i == 0) {
                firstCardCenter = cardView.center;
            }
            lastCardCenter = cardView.center;
            [_cardViewArray addObject:cardView];
        }
    }
    
    // 为每一个卡片填充数据
    for (int i = 0; i < _cardViewArray.count; i++) {
        _lastDataIndex = i;
        CardView *cardView = _cardViewArray[i];
        [cardView updateContent:[_cards objectAtIndex:i]];
        [cardView setNeedsLayout];
    }
}

#pragma mark - UIPanGestureRecognizer
- (void)moveCards:(UIPanGestureRecognizer *)pan {
    
//    CGFloat translate = [pan translationInView:self].x;
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint offset = [pan translationInView:self];
        UIView *dragView = [_cardViewArray firstObject];
        dragView.center = CGPointMake(dragView.center.x+offset.x, dragView.center.y);
        [pan setTranslation:CGPointMake(0, 0) inView:self];
//        NSLog(@"%@:%@", @(dragView.frame.origin.x), @(dragView.width));
        CGPoint endPoint = [pan velocityInView:self];
        NSLog(@"%@", @(endPoint.x));
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint endPoint = [pan velocityInView:self];
        UIView *dragView = [_cardViewArray firstObject];
//        NSLog(@"%@", @(endPoint.x));
        if (endPoint.x < -50 || endPoint.x > 50 ||fabs(dragView.ml_left) > dragView.ml_width/2.f) {
            // 将当前View放到最后面
            CGFloat left = 0.f;
            if (endPoint.x > 0) {
                left = 2*self.ml_width;
            } else if (endPoint.x < 0) {
                left = -self.ml_width;
            } else {
                if (dragView.ml_left > 0) {
                    left = 2*self.ml_width;
                } else if (dragView.ml_left < 0) {
                    left = -self.ml_width;
                }
            }
            [self sendTopCardToLast:left completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self changeSubCard:^(BOOL finished) {
                        [self setLasetCardView];
                    }];
                } completion:^(BOOL finished) {
                }];
            }];
        } else {
            [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                dragView.center = lastCardCenter;
                dragView.transform = CGAffineTransformIdentity;
                [self resetSubCardView];
                
            } completion:nil];
        }
    }
}

#pragma mark - Private methods - next card
- (void)sendTopCardToLast:(CGFloat)left completion:(void (^ __nullable)(BOOL finished))completion
{
    CardView *cardView = [_cardViewArray firstObject];
    [UIView animateWithDuration:0.3 animations:^{
        cardView.ml_left = left;
    } completion:^(BOOL finished) {
        cardView.alpha = 0;
        cardView.ml_left = (self.ml_width - (self.ml_width - kHorizontalSpacing * 2))/2.f;
        
        [_cardViewArray removeObject:cardView];
        [_cardViewArray addObject:cardView];
        [cardView removeFromSuperview];
        [self insertSubview:cardView atIndex:0];
        // 设置最后一张卡牌数据，让后刷新卡牌。
        _lastDataIndex = (_cards.count-1) > _lastDataIndex ? _lastDataIndex+1 : 0;
        [cardView updateContent:[_cards objectAtIndex:_lastDataIndex]];
        [cardView setNeedsLayout];
        completion(finished);
    }];
}

- (void)setLasetCardView
{
    UIView *cardView = [_cardViewArray lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        cardView.alpha = 1;
    }];
}

- (void)changeSubCard:(void (^ __nullable)(BOOL finished))completion
{
    for (NSInteger i = 0; i < _cardViewArray.count; i++) {
        
        UIView *cardView = _cardViewArray[i];
        if (cardView) {
            [UIView animateWithDuration:0.3 animations:^{
                cardView.transform = kCGAffineTransformMakeScale(i);
                cardView.transform = kCGAffineTransformTranslate(i);
            } completion:completion];
        }
    }
}

- (void)resetSubCardView
{
    if (_cardViewArray.count > 1) {
        for (int i = 1; i < _cardViewArray.count; i++) {
            UIView *cardView = _cardViewArray[i];
            if (cardView) {
                cardView.transform = kCGAffineTransformMakeScale(i);
                cardView.transform = kCGAffineTransformTranslate(i);
            }
        }
    }
}

#pragma mark - Private methods - previous
- (void)bringLastCardToTop:(CGFloat)left completion:(void (^ __nullable)(BOOL finished))completion
{
    CardView *cardView = [_cardViewArray lastObject];
    cardView.alpha = 0;
    [_cardViewArray removeObject:cardView];
    [_cardViewArray insertObject:cardView atIndex:0];
    [cardView removeFromSuperview];
    [self insertSubview:cardView atIndex:_cardViewArray.count-1];
    for (NSInteger i = 0; i < _cardViewArray.count; i++) {
        
        UIView *cardView = _cardViewArray[i];
        if (cardView) {
            cardView.transform = kCGAffineTransformMakeScale(i);
            cardView.transform = kCGAffineTransformTranslate(i);
        }
    }
    cardView.alpha = 1;
//    [self changeSubCard:^(BOOL finished) {
////        CardView *cardView = [_cardViewArray firstObject];
////        cardView.alpha = 1;
//        cardView.alpha = 1;
//    }];

//    [UIView animateWithDuration:0.3 animations:^{
////        cardView.left = (self.width - (self.width - kHorizontalSpacing * 2))/2.f;
//
//
//    } completion:^(BOOL finished) {
//        cardView.alpha = 1;
//        cardView.left = left;
//
//        completion(finished);
//    }];

//    设置最后一张卡牌数据，让后刷新卡牌。
//    _lastDataIndex = (_cards.count-1) > _lastDataIndex ? _lastDataIndex+1 : 0;
//    cardView.label.text = _cards[_lastDataIndex];
//    [cardView setNeedsLayout];
}


#pragma mark -
//- (void)changeSubCardView
//{
//    UIView *cardView = [_cardViewArray firstObject];
//    NSLog(@"%.2f",cardView.top);
//    if (_cardViewArray.count > 1) {
//        for (int i = 1; i < _cardViewArray.count; i++) {
//            UIView *card = _cardViewArray[i];
//            if (i == 1) {
//                card.transform = CGAffineTransformMakeScale(1-(i > 2?2:i)*0.02, 1-(i > 2?2:i)*0.02);
//                card.transform = CGAffineTransformTranslate(card.transform, 0, (i > 2?2:i)*kCardSpacting/1.5);
//            } else if(i == 2){
//                card.transform = CGAffineTransformMakeScale(1-(i > 2?2:i)*0.05, 1-(i > 2?2:i)*0.05);
//                card.transform = CGAffineTransformTranslate(card.transform, 0, (i > 2?2:i)*kCardSpacting);
//            }
//        }
//    }
//}

@end
