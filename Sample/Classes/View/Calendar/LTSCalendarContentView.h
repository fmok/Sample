//
//  LTSCalendarContentView.h
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/9.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSCalendarAppearance.h"
#import "LTSCalendarCollectionViewFlowLayout.h"
#import "LTSCalendarEventSource.h"

#define W_CalendarScrollView (kScreenWidth)
#define W_CalendarItem (W_CalendarScrollView/7.f)

@interface LTSCalendarContentView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
//遮罩
@property (nonatomic, strong) UIView *maskView;
//事件代理
@property (nonatomic, weak) id<LTSCalendarEventSource> eventSource;

@property (nonatomic, strong) NSDate *currentDate;
///滚动到单周需要的offset
@property (nonatomic, assign, readonly) CGFloat singleWeekOffsetY;
//
@property (nonatomic, strong, readonly) NSIndexPath *currentSelectedIndexPath;

@property (nonatomic, assign) BOOL isShowBottomLine;

- (void)setSingleWeek:(BOOL)singleWeek;
///下一页
- (void)getDateDatas;
- (void)loadNextPage;
- (void)loadPreviousPage;
- (void)reloadAppearance;
///更新遮罩镂空的位置 
- (void)setUpVisualRegion;
- (void)goBackToday;

- (void)reloadDefaultDate;

@end
