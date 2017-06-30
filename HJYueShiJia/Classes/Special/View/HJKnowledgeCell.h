//
//  HJKnowledgeCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/8.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJKnowledgeModel.h"
@interface HJKnowledgeCell : UITableViewCell
@property (nonatomic,strong)HJKnowledgeModel *model;

-(CGFloat)getCellHeight;
@end
