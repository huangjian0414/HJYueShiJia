//
//  HJHomeCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJHomeCellModel.h"
@interface HJHomeCell : UITableViewCell
@property (nonatomic,strong)HJHomeCellModel *homeCellModel;

-(CGFloat)getCellHeight;
@end
