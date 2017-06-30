//
//  HJListTopCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/7.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJListTopModel.h"
@interface HJListTopCell : UITableViewCell

@property (nonatomic, strong) HJListTopModel *model;

- (CGFloat)getCellHeight;
@end
