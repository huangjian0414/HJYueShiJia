//
//  HJBasketGoodsModel.h
//  HJYueShiJia
//
//  Created by huangjian on 17/5/10.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJBasketGoodsModel : NSObject
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_desc;
@property (nonatomic, strong) NSString *goods_price;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_num;

@property (nonatomic,assign)BOOL isSelected;
@end
