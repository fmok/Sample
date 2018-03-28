//
//  InfoCell.h
//  Sample
//
//  Created by wjy on 2018/3/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardInfoModel.h"

@interface InfoCell : UITableViewCell

- (void)updateContent:(CardInfoModel *)model;

@end
