//
//  HJMapCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMapModel.h"
@interface HJMapCell : UITableViewCell
@property (nonatomic,strong)HJMapModel *model;

-(CGFloat)getCellHeight;
@end
