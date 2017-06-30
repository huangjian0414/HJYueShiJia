//
//  HJGoodsCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGoodsCell.h"

@interface HJGoodsCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *origPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;

@end
@implementation HJGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setGoodsModel:(HJGoodsModel *)goodsModel
{
    self.titleLabel.text=goodsModel.goodsName;
    self.priceLabel.text=[NSString stringWithFormat:@"¥ %@",goodsModel.goodsPrice];
    self.origPriceLabel.attributedText=[UILabel midLineWithString:[NSString stringWithFormat:@"¥ %@",goodsModel.goodsOrigPrice]];
    self.saleNumLabel.text=[NSString stringWithFormat:@"已售%@件",goodsModel.goodsSaleNum];
    
}
-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.priceLabel.frame) + 15;
}

@end
