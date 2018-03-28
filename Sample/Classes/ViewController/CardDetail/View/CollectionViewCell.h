//
//  CollectionViewCell.h
//  Sample
//
//  Created by wjy on 2018/3/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Gap_MylistenInAlbumCell 27.f  // item 内部间隙
#define Gap_MylistenInAlnumEdges 12.f  // item 外部间隙
#define W_H_MylistenInAlbumCell_Image ((kScreenWidth-2*Gap_MylistenInAlnumEdges-2*Gap_MylistenInAlbumCell)/3.f)  // 图片宽高
#define H_MylistenInAlbumCell (W_H_MylistenInAlbumCell_Image+55.f)  // item 高度

@interface CollectionViewCell : UICollectionViewCell

@end
