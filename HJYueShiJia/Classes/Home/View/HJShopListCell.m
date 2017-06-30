//
//  HJShopListCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/25.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJShopListCell.h"
#import "UIImageView+WebCache.h"
@interface HJShopListCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopListLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *origPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;

@end
@implementation HJShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width=Width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShopListModel:(HJShopListModel *)shopListModel
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:shopListModel.goods_image_url]];
    self.shopNameLabel.text=shopListModel.goods_name;
    self.shopListLabel.text=shopListModel.goods_jingle;
    self.priceLabel.text=[NSString stringWithFormat:@"¥ %@",shopListModel.goods_price];
    self.origPriceLabel.attributedText=[UILabel midLineWithString:[NSString stringWithFormat:@"原价：%@",shopListModel.goods_marketprice]];
    self.saleNumLabel.text=[NSString stringWithFormat:@"已售：%@件",shopListModel.goods_salenum];
    
}
-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.saleNumLabel.frame) + 15;
}
@end
