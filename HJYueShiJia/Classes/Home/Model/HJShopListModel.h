//
//  HJShopListModel.h
//  HJYueShiJia
//
//  Created by huangjian on 17/4/25.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJShopListModel : NSObject
@property (nonatomic, strong) NSString *goods_image_url ;
@property (nonatomic, strong) NSString *goods_name ;
@property (nonatomic, strong) NSString *goods_jingle ;
@property (nonatomic, strong) NSString *goods_price ;
@property (nonatomic, strong) NSString *goods_marketprice ;

@property (nonatomic, strong) NSString *goods_salenum;
@end
