//
//  MyPurchaseSizeMacro.h
//  Sample
//
//  Created by wjy on 2018/4/2.
//  Copyright © 2018年 wjy. All rights reserved.
//

#ifndef MyPurchaseSizeMacro_h
#define MyPurchaseSizeMacro_h


#define gap_left_right_myPurchase 14.5f

#define H_topView_myPurchaseCell 32.f
#define gap_PurchaseCell_bottom_MyPurchase 12.f

#define gap_left_right_MyPurchaseCard 12.f
#define gap_middle_MyPurchaseCard 25.f
#define W_MyPurchaseCard ([UIScreen mainScreen].bounds.size.width-2*gap_left_right_myPurchase-2*gap_left_right_MyPurchaseCard-gap_middle_MyPurchaseCard)/2.f
#define H_MyPurchaseCardImgView ((115.f/150)*W_MyPurchaseCard)

#define gap_card_insert_myPurcahse 10.f
#define H_MyPurchaseCard (H_MyPurchaseCardImgView+gap_card_insert_myPurcahse+12.f+gap_card_insert_myPurcahse)


#endif /* MyPurchaseSizeMacro_h */
