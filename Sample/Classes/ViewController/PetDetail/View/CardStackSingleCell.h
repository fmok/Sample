//
//  CardStackSingleCell.h
//  Sample
//
//  Created by wjy on 2018/4/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Gap_CardsStackSingleCellEdges 15.5f
#define W_CardsStackSingleCell (kScreenWidth-Gap_CardsStackSingleCellEdges*2)
#define H_CardsStackSingleCell ((265.5f/345.f)*W_CardsStackSingleCell)

@interface CardStackSingleCell : UICollectionViewCell

- (void)updateContentWithImgUrl:(NSString *)imgUrl;

@end
