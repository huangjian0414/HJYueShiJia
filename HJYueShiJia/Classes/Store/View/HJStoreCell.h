//
//  HJStoreCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJStoreCellModel.h"

@interface HJStoreCell : UITableViewCell
@property (nonatomic,strong)HJStoreCellModel *model;

- (CGFloat)getCellHeight;
@end
