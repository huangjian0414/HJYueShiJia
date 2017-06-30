//
//  HJBasketGoodsCell.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/10.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJBasketGoodsModel.h"
@protocol HJBasketGoodsDelegate <NSObject>

-(void)selectedGoods:(NSIndexPath *)indexPath selectedBtn:(UIButton *)btn;

@end

@interface HJBasketGoodsCell : UITableViewCell
@property (nonatomic,strong)HJBasketGoodsModel *model;
@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,weak)id<HJBasketGoodsDelegate>delegate;

-(CGFloat)getCellHeight;
@end
