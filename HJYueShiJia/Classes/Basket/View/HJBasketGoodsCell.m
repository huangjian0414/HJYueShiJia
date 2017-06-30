//
//  HJBasketGoodsCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/10.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJBasketGoodsCell.h"

@interface HJBasketGoodsCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
@implementation HJBasketGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HJBasketGoodsModel *)model
{
    _model=model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.selectedBtn.selected=model.isSelected;
    self.nameLabel.text=model.goods_name;
    self.descLabel.text=model.goods_desc;
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",model.goods_price];
    self.numLabel.text=[NSString stringWithFormat:@"x%@",model.goods_num];
}
- (IBAction)clickSelectedBtn:(UIButton *)sender {
    sender.selected=!sender.selected;
    if ([self.delegate respondsToSelector:@selector(selectedGoods:selectedBtn:)]) {
        [self.delegate selectedGoods:self.indexPath selectedBtn:sender];
    }
}
-(CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.priceLabel.frame)+15;
}
@end
