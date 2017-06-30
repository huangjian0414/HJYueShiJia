//
//  HJActivityCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJActivityModel.h"
@interface HJActivityCell : UITableViewCell
@property (nonatomic,strong)HJActivityModel *model;

-(CGFloat)getCellHeight;
@end
