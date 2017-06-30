//
//  HJGoodsCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/4/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGoodsModel.h"
@interface HJGoodsCell : UITableViewCell
@property(nonatomic,strong)HJGoodsModel *goodsModel;

-(CGFloat)getCellHeight;
@end
