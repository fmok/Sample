//
//  CollectionViewCell.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CountHorizontalDirection 2

#define Gap_CollectionViewCell 24.f  // 内部间隔
#define Gap_CollectionViewEdges 12.f  // 外部间隔
#define W_CollectionViewCell ((kScreenWidth-2*Gap_CollectionViewEdges-2*Insert_left_right-(CountHorizontalDirection-1)*Gap_CollectionViewCell)/2.f)  // item 宽度

#define H_CollectionViewCell (W_CollectionViewCell+55.f)  // item 高度

@interface CollectionViewCell : UICollectionViewCell

@end
