//
//  HJStoreHomeCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/2.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJStoreHomeCellModel.h"

@interface HJStoreHomeCell : UICollectionViewCell
@property (nonatomic, assign) BOOL isGrid;
@property (nonatomic,strong) HJStoreHomeCellModel *storeHomeCellModel;
@end
