//
//  HJToolBarView.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/26.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJToolBarView.h"
#import "HJToolButton.h"

@implementation HJToolBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
-(void)setUI
{
    HJToolButton *basketBtn=[HJToolButton buttonWithType:UIButtonTypeCustom];
    [basketBtn setImage:[UIImage imageNamed:@"YS_car_sel"] forState:UIControlStateNormal];
    [basketBtn setTitle:@"购物篮" forState:UIControlStateNormal];
    [basketBtn addTarget:self action:@selector(clickBasketBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:basketBtn];
    
    HJToolButton *storeBtn=[HJToolButton buttonWithType:UIButtonTypeCustom];
    [storeBtn setImage:[UIImage imageNamed:@"ysstoreIcon"] forState:UIControlStateNormal];
    [storeBtn setTitle:@"店铺" forState:UIControlStateNormal];
    [storeBtn addTarget:self action:@selector(clickStoreBtn) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:storeBtn];
    
    HJToolButton *likeBtn=[HJToolButton buttonWithType:UIButtonTypeCustom];
    [likeBtn setImage:[UIImage imageNamed:@"shop_collection"] forState:UIControlStateNormal];
    [likeBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(clicklikeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:likeBtn];
    
    UIButton *addBasketBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [addBasketBtn setTitle:@"加入购物篮" forState:UIControlStateNormal];
    [addBasketBtn setBackgroundColor:RGB(190, 160, 150, 1)];
    addBasketBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [addBasketBtn addTarget:self action:@selector(clickaddBasketBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBasketBtn];
    
    UIButton *buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"立刻购买" forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:RGB(230, 198, 168, 1)];
    buyBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [buyBtn addTarget:self action:@selector(clickbuyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyBtn];
    
    basketBtn.sd_layout.leftEqualToView(self).topEqualToView(self).bottomEqualToView(self).widthIs((self.width/2+20)/3);
    storeBtn.sd_layout.leftSpaceToView(basketBtn,0).topEqualToView(self).bottomEqualToView(self).widthRatioToView(basketBtn,1);
    likeBtn.sd_layout.leftSpaceToView(storeBtn,0).topEqualToView(self).bottomEqualToView(self).widthRatioToView(storeBtn,1);
    addBasketBtn.sd_layout.leftSpaceToView(likeBtn,0).topEqualToView(self).bottomEqualToView(self).widthIs((self.width/2-20)/2);
    buyBtn.sd_layout.leftSpaceToView(addBasketBtn,0).topEqualToView(self).bottomEqualToView(self).widthRatioToView(addBasketBtn,1);

}
-(void)clickBasketBtn
{
    if ([self.delegate respondsToSelector:@selector(touchBasket)]) {
        [self.delegate touchBasket];
    }
    //[SVProgressHUD showSuccessWithStatus:@"兄弟，你点击了购物篮！"];
}
-(void)clickStoreBtn
{
    //[SVProgressHUD showSuccessWithStatus:@"兄弟，你点击了店铺！"];
    if ([self.delegate respondsToSelector:@selector(touchStore)]) {
        [self.delegate touchStore];
    }
    
}
-(void)clicklikeBtn
{
    [SVProgressHUD showSuccessWithStatus:@"兄弟，你点击了收藏！"];
}
-(void)clickaddBasketBtn
{
    if ([self.delegate respondsToSelector:@selector(touchAddBasket)]) {
        [self.delegate touchAddBasket];
    }
}
-(void)clickbuyBtn
{
    [SVProgressHUD showSuccessWithStatus:@"兄弟，你点击了立即购买！"];
}
@end
