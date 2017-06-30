//
//  HJBuyView.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/1.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGoodsModel.h"

@protocol HJBuyViewDelegate <NSObject>

-(void)touchDoneWith:(NSInteger)num ImageView:(UIImageView *)ImgView;

@end
@interface HJBuyView : UIView
@property (nonatomic,strong)HJGoodsModel *goodsModel;
@property (nonatomic,copy)NSString *imageStr;
@property (nonatomic,weak)id<HJBuyViewDelegate>delegate;
@end
