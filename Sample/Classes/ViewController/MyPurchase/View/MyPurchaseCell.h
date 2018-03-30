//
//  MyPurchaseCell.h
//  Sample
//
//  Created by wjy on 2018/3/30.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CountHorizontalDirection_myPurchase 2

#define Gap_MyPurchaseCell 24.f  // 中间间隔
#define Gap_MyPurchaseCellEdges 12.5f  // 外部间隔
#define W_MyPurchaseCell ((kScreenWidth-2*Gap_MyPurchaseCellEdges-2*gap_left_right_myPurchase-(CountHorizontalDirection_myPurchase-1)*Gap_MyPurchaseCell)/2.f)  // item 宽度

#define H_MyPurchaseCell (W_MyPurchaseCell)  // item 高度

@interface MyPurchaseCell : UICollectionViewCell

@end
