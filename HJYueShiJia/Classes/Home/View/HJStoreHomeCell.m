//
//  HJStoreHomeCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/2.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJStoreHomeCell.h"

@interface HJStoreHomeCell ()
@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *origPriceLabel;
@property (nonatomic, strong) UILabel *saleNumLabel;

@end
@implementation HJStoreHomeCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    self.picImageView=imageView;
    [self.contentView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    priceLabel.textColor = RGB(230, 198, 168, 1);
    priceLabel.font = [UIFont systemFontOfSize:13];
    self.priceLabel = priceLabel;
    [self.contentView addSubview:priceLabel];
    
    UILabel *marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    marketPriceLabel.textColor = [UIColor lightGrayColor];
    marketPriceLabel.font = [UIFont systemFontOfSize:13];
    self.origPriceLabel = marketPriceLabel;
    [self.contentView addSubview:marketPriceLabel];
    
    UILabel *saleNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    saleNumLabel.textColor = [UIColor lightGrayColor];
    saleNumLabel.textAlignment=NSTextAlignmentRight;
    saleNumLabel.font = [UIFont systemFontOfSize:13];
    self.saleNumLabel = saleNumLabel;
    [self.contentView addSubview:saleNumLabel];
}
-(void)setIsGrid:(BOOL)isGrid
{
    if (!isGrid) {
        self.picImageView.sd_resetNewLayout.leftSpaceToView(self.contentView,5).topSpaceToView(self.contentView,8).heightIs(self.height-16).widthIs(self.height-16);
        self.titleLabel.sd_resetNewLayout.leftSpaceToView(self.picImageView,5).topEqualToView(self.picImageView).rightEqualToView(self.contentView).autoHeightRatio(0);
        self.priceLabel.sd_resetNewLayout.leftEqualToView(self.titleLabel).topSpaceToView(self.titleLabel,8).widthIs(100).heightIs(20);
        self.saleNumLabel.sd_resetNewLayout.rightSpaceToView(self.contentView,5).topEqualToView(self.priceLabel).heightIs(20).widthIs(100);
        self.origPriceLabel.sd_resetNewLayout.leftEqualToView(self.priceLabel).topSpaceToView(self.priceLabel,8).widthIs(100).heightIs(20);
        //[super updateConstraints];
        
        
    }else
    {
        self.picImageView.sd_resetNewLayout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,8).rightSpaceToView(self.contentView,10).heightEqualToWidth(self.picImageView);
        self.titleLabel.sd_resetNewLayout.leftSpaceToView(self.contentView,5).topSpaceToView(self.picImageView,5).rightSpaceToView(self.contentView,5).autoHeightRatio(0);
        self.priceLabel.sd_resetNewLayout.leftEqualToView(self.titleLabel).topSpaceToView(self.titleLabel,5).widthIs(60).heightIs(20);
        self.saleNumLabel.sd_resetNewLayout.topEqualToView(self.priceLabel).rightSpaceToView(self.contentView,5).widthIs(100).heightIs(20);
        self.origPriceLabel.sd_resetNewLayout.leftEqualToView(self.priceLabel).topSpaceToView(self.priceLabel,5).widthIs(60).heightIs(20);
         //[super updateConstraints];
        
    }
    
    
}
-(void)setStoreHomeCellModel:(HJStoreHomeCellModel *)storeHomeCellModel
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:storeHomeCellModel.goods_image]];
    self.titleLabel.text=storeHomeCellModel.goods_name;
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",storeHomeCellModel.goods_price];
    self.origPriceLabel.attributedText=[UILabel midLineWithString:[NSString stringWithFormat:@"￥%@",storeHomeCellModel.goods_marketprice]];
    self.saleNumLabel.text=[NSString stringWithFormat:@"已售%@件",storeHomeCellModel.goods_salenum];
}
@end
