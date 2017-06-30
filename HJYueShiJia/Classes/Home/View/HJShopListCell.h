//
//  HJShopListCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/4/25.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJShopListModel.h"
@interface HJShopListCell : UITableViewCell
@property (nonatomic,strong)HJShopListModel *shopListModel;
-(CGFloat)getCellHeight;
@end
