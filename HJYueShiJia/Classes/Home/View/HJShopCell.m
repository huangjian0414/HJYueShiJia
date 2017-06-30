//
//  HJShopCell.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/25.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJShopCell.h"

@interface HJShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation HJShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = RGB(211, 192, 162,1).CGColor;
}
-(void)setShopCellModel:(HJShopCellModel *)shopCellModel
{
    self.imageView.image=[UIImage imageNamed:shopCellModel.imageName];
    self.nameLabel.text=shopCellModel.name;
    self.priceLabel.text=[NSString stringWithFormat:@"$ %.2f",[shopCellModel.price doubleValue]];
}
@end
